Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274774AbRJNHuc>; Sun, 14 Oct 2001 03:50:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274766AbRJNHuX>; Sun, 14 Oct 2001 03:50:23 -0400
Received: from pizda.ninka.net ([216.101.162.242]:50571 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S274752AbRJNHuM>;
	Sun, 14 Oct 2001 03:50:12 -0400
Date: Sun, 14 Oct 2001 00:50:41 -0700 (PDT)
Message-Id: <20011014.005041.39156727.davem@redhat.com>
To: Mika.Liljeberg@welho.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: TCP acking too fast
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3BC9393D.765A156@welho.com>
In-Reply-To: <3BC8DAF0.3D16A546@welho.com>
	<20011013.234016.104032175.davem@redhat.com>
	<3BC9393D.765A156@welho.com>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Mika Liljeberg <Mika.Liljeberg@welho.com>
   Date: Sun, 14 Oct 2001 10:05:33 +0300
   
   Looking at the dump, it seems that most arriving
   segments have the PSH bit set.

I know you said what is running on the receiver, but do
you have any clue what is running on the sender?  It looks
_really_ broken.

The transfer looks like a bulk one but every segment (as you have
stated) has PSH set, which is completely stupid.

At least, I can guarentee you that the sender is not Linux.  Or,
if it is Linux, it is running a really broken implementation of
a web server. :-)

Franks a lot,
David S. Miller
davem@redhat.com
