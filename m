Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274920AbRJNJDW>; Sun, 14 Oct 2001 05:03:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274951AbRJNJDC>; Sun, 14 Oct 2001 05:03:02 -0400
Received: from pizda.ninka.net ([216.101.162.242]:30860 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S274920AbRJNJC5>;
	Sun, 14 Oct 2001 05:02:57 -0400
Date: Sun, 14 Oct 2001 02:03:26 -0700 (PDT)
Message-Id: <20011014.020326.18308527.davem@redhat.com>
To: Mika.Liljeberg@welho.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: TCP acking too fast
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3BC94F3A.7F842182@welho.com>
In-Reply-To: <3BC9441C.887258DA@welho.com>
	<20011014.011246.59654800.davem@redhat.com>
	<3BC94F3A.7F842182@welho.com>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Mika Liljeberg <Mika.Liljeberg@welho.com>
   Date: Sun, 14 Oct 2001 11:39:22 +0300
   
   [Otherwise a sender can force us into a permanent quickack mode
   simply by setting PSH on every segment.]

"A sending TCP can send us garbage so bad that it hinders
performance."

So, your point is? :-)  A sensible sending application, and a sensible
TCP should not being setting PSH every single segment.  And we're not
coding up hacks to make the Linux receiver handle this case better.
You'll have much better luck convincing us to implement ECN black hole
workarounds :-)

Franks a lot,
David S. Miller
davem@redhat.com

