Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288114AbSA0QXB>; Sun, 27 Jan 2002 11:23:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288124AbSA0QWv>; Sun, 27 Jan 2002 11:22:51 -0500
Received: from mailout05.sul.t-online.com ([194.25.134.82]:7899 "EHLO
	mailout05.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S288114AbSA0QWp>; Sun, 27 Jan 2002 11:22:45 -0500
Date: Sun, 27 Jan 2002 17:21:50 +0100
From: "W. Michael Petullo" <mike@flyn.org>
To: linux-kernel@vger.kernel.org
Subject: SMP Pentium III, GA-6VXDC7 MoBo. -- 2.4.18-pre7 SMP not working
Message-ID: <20020127172150.A1407@dragon.flyn.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
X-Operating-System: Linux dragon.flyn.org 2.4.18-pre7 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a home-built dual Pentium III computer which does not seem to
want to run recent SMP kernels.  The computer is built on a Gigabyte
GA-6VXDC7 motherboard, which is in turn based on a VIA Apollo Pro chip-set.
It is an exclusively SCSI system -- I do not compile any IDE drivers
into my kernel.

Kernel 2.4.12 works fine when compiled with SMP on.  However, anything
newer fails to load when compiled with SMP support.  In the failing cases,
lilo prints its uncompressing kernel and booting kernel messages followed
by a system hang -- the kernel never prints anything.

Kernel.org
Vanilla		CONFIG_SMP=y		# CONFIG_SMP is not set
Version		SMP Status		UP Status
======================================================
2.4.10		SMP works		Fine
2.4.11		Wouldn't touch		Wouldn't touch
2.4.12		SMP Works		Fine
2.4.13		SMP does not boot	Fine
2.4.14		Did not try		Did not try
2.4.15		Did not try		Did not try
2.4.16		SMP does not boot	Fine
2.4.17		SMP does not boot	Fine
2.4.18-pre7	SMP does not boot	Fine

Since the kernel does not even peep an oops message, I'm not sure where
to start debugging.  Is anyone else having similar problems?
-- 
Mike

:wq
