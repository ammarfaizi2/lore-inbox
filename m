Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264798AbSKNIbq>; Thu, 14 Nov 2002 03:31:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264799AbSKNIbq>; Thu, 14 Nov 2002 03:31:46 -0500
Received: from TYO202.gate.nec.co.jp ([210.143.35.52]:21729 "EHLO
	TYO202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id <S264798AbSKNIbp>; Thu, 14 Nov 2002 03:31:45 -0500
From: SL Baur <steve@kbuxd.necst.nec.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15827.24963.123936.782801@sofia.bsd2.kbnes.nec.co.jp>
Date: Thu, 14 Nov 2002 17:40:35 +0900
To: Shaya Potter <spotter@cs.columbia.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: figuring out which ioctl's a system needs?
X-Mailer: VM 7.03 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'm trying to figure out what is the subset of ioctl's a system needs
> to run. I figure the best way is sticking a printk in sys_ioctl, and
> having it printk the number, so that syslog can pick it up, and then
> go through the list. This way I can use the system normally for a
> week to collect the information I need.

> Is there an easier way, or is there a way that I can make my life
> easier (i.e. going from printk'd number to header file include).

Install the Linux Trace Toolkit and enable tracing for ioctls.
See http://www.opersys.com/LTT for details.

