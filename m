Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262057AbVEQWnA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262057AbVEQWnA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 18:43:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262048AbVEQWla
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 18:41:30 -0400
Received: from rrcs-24-227-247-8.sw.biz.rr.com ([24.227.247.8]:2176 "EHLO
	emachine.austin.ammasso.com") by vger.kernel.org with ESMTP
	id S262039AbVEQWjf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 18:39:35 -0400
Message-ID: <428A729E.8040207@ammasso.com>
Date: Tue, 17 May 2005 17:39:26 -0500
From: Timur Tabi <timur.tabi@ammasso.com>
Reply-To: linux-kernel@vger.kernel.org
Organization: Ammasso
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.5) Gecko/20041217 Mnenhy/0.7.2.0
X-Accept-Language: en-us, en, en-gb
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: sparse error: unable to open 'stdarg.h'
References: <428A661C.1030100@ammasso.com>
In-Reply-To: <428A661C.1030100@ammasso.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Timur Tabi wrote:

> make -C /lib/modules/2.6.8-24-smp/source 
> SUBDIRS=/root/AMSO1100/software/host/linux/sys/devccil  C=1 V=2

When I replace V=2 with V=1 (don't know how that happened), I get this output:

sparse  -D__i386__=1 -Wp,-MD,/root/AMSO1100/software/host/linux/sys/devccil/.devnet.o.d 
-nostdinc -iwithprefix include -D__KERNEL__ -Iinclude  -Wall -Wstrict-prototypes 
-Wno-trigraphs -fno-strict-aliasing -fno-common -O2 -fomit-frame-pointer  -pipe 
-msoft-float -mpreferred-stack-boundary=2 -funit-at-a-time -fno-unit-at-a-time -march=i586 
-mregparm=3 -mcpu=i686 -Iinclude/asm-i386/mach-generic -Iinclude/asm-i386/mach-default 
-DCCNOPRINTF -DX86_32 -DEXPORT_SYMTAB -Wall  -I/root/AMSO1100/software/host/linux/include 
-I/root/AMSO1100/software/host/common/include  -I/root/AMSO1100/software/common/include 
-I/root/AMSO1100/software/common/include/clustercore 
-I/root/AMSO1100/software/host/linux/common 
-I/root/AMSO1100/software/host/linux/sys/devccil  -DREMAP_API_CHANGE -DINCLUDE_CURRENT 
-DNET_DEVICE_HAS_IW -DPCI_SAVE_STATE_BUFFER -DQDISC_LIST_HEAD -DPCI_DMA_CPU -DUSE_GUP 
-DCCIL_KDAPL -DCCTHREADSAFE 
-Wa,-aldh=/root/AMSO1100/software/host/linux/sys/devccil/devnet.lst  -DMODULE 
-DKBUILD_BASENAME=devnet -DKBUILD_MODNAME=ccil 
/root/AMSO1100/software/host/linux/sys/devccil/devnet.c ;


-- 
Timur Tabi
Staff Software Engineer
timur.tabi@ammasso.com

One thing a Southern boy will never say is,
"I don't think duct tape will fix it."
      -- Ed Smylie, NASA engineer for Apollo 13
