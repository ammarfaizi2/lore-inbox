Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262450AbTI0PRm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Sep 2003 11:17:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262458AbTI0PRm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Sep 2003 11:17:42 -0400
Received: from eva.fit.vutbr.cz ([147.229.10.14]:29713 "EHLO eva.fit.vutbr.cz")
	by vger.kernel.org with ESMTP id S262450AbTI0PRk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Sep 2003 11:17:40 -0400
Date: Sat, 27 Sep 2003 17:17:36 +0200
From: David Jez <dave.jez@seznam.cz>
To: Piotr =?iso-8859-2?Q?Szyma=F1ski?= <djurban@gnu.univ.gda.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: urb timeouts with eagle on 2.4.20
Message-ID: <20030927151736.GA81700@stud.fit.vutbr.cz>
References: <200309271643.25235.djurban@gnu.univ.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200309271643.25235.djurban@gnu.univ.gda.pl>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 27, 2003 at 04:43:25PM +0200, Piotr Szymañski wrote:
> Hi,
  Hi,

> I have a problem with my sagem 800 modem on my USB Controller: VIA 
> Technologies, Inc. USB (rev 10), using kernel 2.4.20.
> After connecting to the net, the modem disconnects and I get an error:
> ***
> Sep 27 12:51:56 niedakh NETDEV WATCHDOG: eth0: transmit timed out
> Sep 27 12:51:56 niedakh [Adi] Transmit timed out!
> Sep 27 12:51:56 niedakh [Adi] transmit URB e5cce0bc cancelled
> ***
> I have to reload its firmware in order for it to work again. 
> I talked to manypeople about this. I was told to try booting with noapic or 
> acpi=off. Unfortunately the same error happened with apci=off or  noapic or 
> even both.  On eagle forums I was pointed to check my controllers altency 
> (how do you do that?) which reminded me I had a similar situation on win2k on 
  lspci -v

  Ofcourse, you can use powertweak utility too.

> the same machine, but after installing via 4in1 update for usb it started to 
> work properly on win2k. i google for "usb via latency" and found a via usb 
  hmm, this sound interesting. So, did you tried use uhci usb adapter
instead of usb-uhci? Maybe it will works better.

> latency patch for windows, I didnt find a linux version of the latency patch 
> for via anywhere.
> Noone around knows how to fix this, so Im mailing here.
> Thanks for any replies.
> -- 
> Piotr Szymañski
> djurban@gnu.univ.gda.pl; djurban.jogger.pl

-- 
-------------------------------------------------------
  David "Dave" Jez                Brno, CZ, Europe
 E-mail: dave.jez@seznam.cz
PGP key: finger xjezda00@eva.fit.vutbr.cz
---------=[ ~EOF ]=------------------------------------
