Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264948AbSKERFt>; Tue, 5 Nov 2002 12:05:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264907AbSKERFs>; Tue, 5 Nov 2002 12:05:48 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:33231 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S264948AbSKERFq>; Tue, 5 Nov 2002 12:05:46 -0500
From: Alan Cox <alan@redhat.com>
Message-Id: <200211051712.gA5HCFE18350@devserv.devel.redhat.com>
Subject: Re: [BUG] multicast routing, ipmr.c
To: dcowart@cog.ufl.edu (Donald Cowart)
Date: Tue, 5 Nov 2002 12:12:15 -0500 (EST)
Cc: alan@redhat.com, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0211051102390.5594-100000@yaun.cog.ufl.edu> from "Donald Cowart" at Nov 05, 2002 12:01:08 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> When I compile 2.5.46 with multicast routing enabled (CONFIG_IP_MROUTE) i
> get the following error:
> 
>  gcc -Wp,-MD,net/ipv4/.ipmr.o.d -D__KERNEL__ -Iinclude -Wall 
> -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer 
> -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 
> -march=pentium3 -Iarch/i386/mach-generic -nostdinc -iwithprefix include    
> -DKBUILD_BASENAME=ipmr   -c -o net/ipv4/ipmr.o net/ipv4/ipmr.c
> net/ipv4/ipmr.c: In function `ipmr_forward_finish':
> net/ipv4/ipmr.c:1114: structure has no member named `pmtu'
> net/ipv4/ipmr.c: In function `ipmr_queue_xmit':
> net/ipv4/ipmr.c:1170: structure has no member named `pmtu'

Grab the patch bit to that file from 2.5.45-ac1 until its fixed

