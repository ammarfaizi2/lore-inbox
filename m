Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262466AbUKDX2j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262466AbUKDX2j (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 18:28:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262493AbUKDX2j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 18:28:39 -0500
Received: from smtpout2.uol.com.br ([200.221.11.55]:35716 "EHLO
	smtp.uol.com.br") by vger.kernel.org with ESMTP id S262466AbUKDX1P
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 18:27:15 -0500
Date: Thu, 4 Nov 2004 21:27:04 -0200
From: =?iso-8859-1?Q?Rog=E9rio?= Brito <rbrito@ime.usp.br>
To: linux-kernel@vger.kernel.org
Subject: Oops with kernel 2.6.9-ac6
Message-ID: <20041104232704.GA7721@ime.usp.br>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Dear kernel developers (and Alan Cox in particular),

I've been having problems with recent kernels (some instability
on a system that has been rock solid for years). I'm using a Debian testing
system here with my own compiled kernel.

I've been tracking almost all the -rc releases that Linus has published and
it seems that while 2.6.10-rc1 contains all the fixes that I need
(including the fix for making my USB Drive working correctly and the
ability for my iBook to change its speed), it doesn't seem stable enough on
my desktop.

For instance, while I was at work connected to my desktop via ssh, the
machine simply got frozen -- when I came back home, the only thing that
worked was SysRq+B for booting (I had X running and the monitor at that
time didn't receive signal from the card).

For this reason, I went back to kernel 2.6.9-ac6 to see if a more
conservative change would bring more stability. I got some Ooopsen today
when I was ripping some CDs with grip under X and browsing the web with
Mozilla. In fact, Mozilla died many times and I just thought that it was
Mozilla's fault. But then I saw many lines rolling in an xconsole that I
always keep open.

I've put the logs of what I got at <http://www.ime.usp.br/~rbrito/bug/>.  I
don't know exactly what would be relevant information to report, but feel
free to ask about any details.

My motherboard is an Asus A7V, with chipset Via KT133, a Duron 600MHz,
386MB of RAM, a vanilla Firewire card (with a Via chipset), two vanilla
Realtek 8139 cards, a Matrox G400 AGP card with 16MB of RAM, a ES1371 card
and a US Robotics modem (I'm describing the hardware here because I can't
connect to my computer right now to get a lspci output).

Anyway, I would really appreciate any help that you could offer.


Thanks in advance, Rogério Brito.

-- 
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
  Rogério Brito - rbrito@ime.usp.br - http://www.ime.usp.br/~rbrito
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
