Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275941AbSIUULT>; Sat, 21 Sep 2002 16:11:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275940AbSIUULT>; Sat, 21 Sep 2002 16:11:19 -0400
Received: from 62-190-219-210.pdu.pipex.net ([62.190.219.210]:5 "EHLO
	darkstar.example.net") by vger.kernel.org with ESMTP
	id <S275941AbSIUULS>; Sat, 21 Sep 2002 16:11:18 -0400
From: jbradford@dial.pipex.com
Message-Id: <200209212023.g8LKNC9i001545@darkstar.example.net>
Subject: Re: Loading kernel
To: thunder@lightweight.ods.org (Thunder from the hill)
Date: Sat, 21 Sep 2002 21:23:12 +0100 (BST)
Cc: chavvasrini@yahoo.com, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0209201846520.342-100000@hawkeye.luckynet.adm> from "Thunder from the hill" at Sep 20, 2002 06:47:41 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Fri, 20 Sep 2002, Srinivas Chavva wrote:
> > "
> > /etc/rc.sysinit: /var/log/dmesg: No such file or
> > directory
> > /etc/rc.sysinit: /var/log/ksyms.o: No such file or
> > directory
> > INIT: Entering run level:3
> > Updating /etc/fstab execvp: No such file or directory
> > 					[FAILED]
> > Checking for new hardware
> > /etc/rc3.d/S05Kudzu:/usr/sbin/kudzu: No such file or
> > directory
> > 					[FAILED]
> > touch:creating '/var/lock/subsys/kudzu': No such file
> > or directory
> > "
> 
> That's really no kernel issue. The kernel seems to have booted fine, and 
> I'd doubt that's fs corruption.

Agreed, except that I think that the old kernel has been re-loaded instead of the new one, because lilo hasn't been re-run.

Lilo does not automatically re-read it's config file, like grub does, (apparently, I use lilo exclusively), and you need to run lilo before re-booting after installing a new kernel image.

John.
