Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262970AbSJGKia>; Mon, 7 Oct 2002 06:38:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262974AbSJGKi3>; Mon, 7 Oct 2002 06:38:29 -0400
Received: from pizda.ninka.net ([216.101.162.242]:51095 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S262970AbSJGKi3>;
	Mon, 7 Oct 2002 06:38:29 -0400
Date: Mon, 07 Oct 2002 03:36:44 -0700 (PDT)
Message-Id: <20021007.033644.85392050.davem@redhat.com>
To: simon@baydel.com
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: The end of embedded Linux?
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3DA16A9B.7624.4B0397@localhost>
References: <20021005.212832.102579077.davem@redhat.com>
	<1033923206.21282.28.camel@irongate.swansea.linux.org.uk>
	<3DA16A9B.7624.4B0397@localhost>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: "" <simon@baydel.com>
   Date: Mon, 7 Oct 2002 11:06:03 +0100

   No one else can run these drivers so 
   how could I expect someone else to maintain them ?

This is a common misconception.  When sweeping API changes
are made to fix some bug or whatever, if your driver is in
the tree the person making the API change will update your
driver or add a comment saying "the new API does this, I
couldn't figure out how to do that with your driver, please
update" in a comment.

You get free work like this just as a side effect of being
in the tree.

It will also be sanity build checked by lots of people who
run the current kernels through a "enable everything" configuration.
   
   However I can not understand how it would be practical for many
   organizations  to  release code under the GPL for specific hardware.

See above.

   This to some companies is too much to give 
   away. Perhaps someone could educate me on this point ?
   
You talked about an interrupt controller, a serial port, lack of VGA,
and lack of RTC on your system... doesn't sound like any ground
breaking hardware to me.

Franks a lot,
David S. Miller
davem@redhat.com
