Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276097AbRJGE5N>; Sun, 7 Oct 2001 00:57:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276099AbRJGE5D>; Sun, 7 Oct 2001 00:57:03 -0400
Received: from pizda.ninka.net ([216.101.162.242]:30340 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S276097AbRJGE4x>;
	Sun, 7 Oct 2001 00:56:53 -0400
Date: Sat, 06 Oct 2001 21:57:17 -0700 (PDT)
Message-Id: <20011006.215717.41650670.davem@redhat.com>
To: torvalds@transmeta.com
Cc: tori@ringstrom.mine.nu, sim@netnation.com, linux-kernel@vger.kernel.org
Subject: Re: 2.4.11pre4 swapping out all over the place
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.33.0110061457570.1454-100000@penguin.transmeta.com>
In-Reply-To: <Pine.LNX.4.33.0110061948280.30116-100000@boris.prodako.se>
	<Pine.LNX.4.33.0110061457570.1454-100000@penguin.transmeta.com>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Linus Torvalds <torvalds@transmeta.com>
   Date: Sat, 6 Oct 2001 14:59:04 -0700 (PDT)

   Ok, can you try this slightly more involved patch instead?
   ...

   --- pre4/linux/mm/oom_kill.c	Thu Oct  4 19:52:11 2001
   +++ linux/mm/oom_kill.c	Fri Oct  5 13:13:43 2001
   @@ -241,13 +241,12 @@

I think you hand edited this patch a little too much this
time :-)  Or something else went wrong, as I had to apply
this by hand myself as patch complained about the first chunk
being malformed.

Franks a lot,
David S. Miller
davem@redhat.com
