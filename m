Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291719AbSBHSTy>; Fri, 8 Feb 2002 13:19:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291712AbSBHSTq>; Fri, 8 Feb 2002 13:19:46 -0500
Received: from nat-pool-meridian.redhat.com ([12.107.208.200]:11094 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S291704AbSBHSTb>; Fri, 8 Feb 2002 13:19:31 -0500
Date: Fri, 8 Feb 2002 13:19:25 -0500
From: Pete Zaitcev <zaitcev@redhat.com>
Message-Id: <200202081819.g18IJPa22033@devserv.devel.redhat.com>
To: linux@sparker.net, linux-kernel@vger.kernel.org
Subject: Re: Sysrq enhancement: process kill facility
In-Reply-To: <mailman.1013189761.2392.linux-kernel2news@redhat.com>
In-Reply-To: <mailman.1013189761.2392.linux-kernel2news@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> You enter <alt>-<sysrq>-n ("nuke"), and then prompts for the pid.  It supports
> backspace and control-U.  On serial ports, it retains the same semantics:
> a break activates this as a sysrq sequence, but if more than 5-seconds pass
> without any input, it drops out of processing input as a sysrq.

I am afraid we'll have bash and perl in kernel before too long,
if this avenue is to be pursued.

Why don't you use something like SGI kdb for debugging kernels?

-- Pete
