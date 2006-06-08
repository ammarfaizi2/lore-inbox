Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964776AbWFHKmZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964776AbWFHKmZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 06:42:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964777AbWFHKmZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 06:42:25 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:8681 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S964776AbWFHKmY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 06:42:24 -0400
Date: Thu, 8 Jun 2006 12:42:13 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: "Majumder, Rajib" <rajib.majumder@credit-suisse.com>
cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: binary portability
In-Reply-To: <F444CAE5E62A714C9F45AA292785BED30EB9719C@esng11p33001.sg.csfb.com>
Message-ID: <Pine.LNX.4.61.0606081240370.19327@yvahk01.tjqt.qr>
References: <F444CAE5E62A714C9F45AA292785BED30EB9719C@esng11p33001.sg.csfb.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>I have some binaries built on a RHEL 3/EM64T platform. Can I directly 
>port them to an RHEL 3/AMD64 platform and run without any issue? 
>
That should work just as much as you can run binaries built on an 
x86/pentium4 platform run on x86/athlon-xp, provided you only compiled with 
the features that both processors support.

>I know that EM64T and AMD64 are ISA compatible, but there could be some 
>differences in ELF32 between these 2 processor architectures. 
>
What differences? (Apart from MMXEXT and SSE2,SSE3)

>Any input will be appreciated. 
>

Jan Engelhardt
