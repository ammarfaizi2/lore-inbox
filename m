Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287487AbSBCRnu>; Sun, 3 Feb 2002 12:43:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287493AbSBCRnl>; Sun, 3 Feb 2002 12:43:41 -0500
Received: from hermes.toad.net ([162.33.130.251]:13294 "EHLO hermes.toad.net")
	by vger.kernel.org with ESMTP id <S287488AbSBCRna>;
	Sun, 3 Feb 2002 12:43:30 -0500
Subject: Re: stumped with APM suspend/resume problem going from 2.4.5 ->
	2.4.17
From: Thomas Hood <jdthood@mail.com>
To: linux-kernel@vger.kernel.org
Cc: Luis Miguel Tavora <lmtavora@saturno.fis.uc.pt>, Matt <mjg23@yahoo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.1 
Date: 03 Feb 2002 12:43:30 -0500
Message-Id: <1012758216.806.44.camel@thanatos>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> ... ever since I got a USB scanner and camera ...
> "apm -s" and 
> then resume causes the machine to hang.  On resume, even
> outside of X, the screen blanks or appears but doesn't
> respond to keyboard input.  No oops, no messages, no nothing.
> The only choice I have at that point is a hard reset.

This sounds similar to an earlier report:
http://marc.theaimsgroup.com/?l=linux-kernel&m=101224645320919&w=2

>  If the computer is  put to rest 
> (apm -s) with the (logitech) usb  mouse plugged in, 
> the  PC doesn't recover at all,  going into a 
> reboot sequence. If the mouse is  unplugged before 
> "apm -s", everything goes  well... 
> No problem as  well if the mouse is connected to 
> the PS2 port. 

Sounds like a USB problem to me.  It would be most useful
to know exactly which kernels have the problem and which
ones don't.

--
Thomas Hood

