Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266345AbTGENZk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Jul 2003 09:25:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266349AbTGENZk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Jul 2003 09:25:40 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:54685
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S266345AbTGENZj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Jul 2003 09:25:39 -0400
Subject: Re: 2.4 BK compile failure in dmi_scan: `BROKEN_PNP_BIOS'
	undeclared
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Duncan Sands <baldrick@wanadoo.fr>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200307051356.35663.baldrick@wanadoo.fr>
References: <200307051356.35663.baldrick@wanadoo.fr>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1057412245.23488.5.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 05 Jul 2003 14:37:25 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2003-07-05 at 12:56, Duncan Sands wrote:
> make[2]: Entering directory `/home/duncan/linux-2.4/arch/i386/kernel'
> gcc -D__KERNEL__ -I/home/duncan/linux-2.4/include -Wall -Wstrict-prototypes -Wno-trigraphs
> -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2
> -march=athlon   -nostdinc -iwithprefix include -DKBUILD_BASENAME=dmi_scan  -c -o dmi_scan.o
> dmi_scan.c
> dmi_scan.c: In function `exploding_pnp_bios':
> dmi_scan.c:521: error: `BROKEN_PNP_BIOS' undeclared (first use in this function)
> dmi_scan.c:521: error: (Each undeclared identifier is reported only once
> dmi_scan.c:521: error: for each function it appears in.)
> dmi_scan.c: In function `dmi_decode':
> dmi_scan.c:944: warning: unused variable `data'

Marcelo hasn't yet applied all the changes I sent him, including some
that depend on each other. Just pull that change from -ac or wait

