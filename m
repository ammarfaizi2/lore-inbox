Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280804AbRKOKHu>; Thu, 15 Nov 2001 05:07:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280807AbRKOKHk>; Thu, 15 Nov 2001 05:07:40 -0500
Received: from gold.MUSKOKA.COM ([216.123.107.5]:4618 "EHLO gold.muskoka.com")
	by vger.kernel.org with ESMTP id <S280804AbRKOKHZ>;
	Thu, 15 Nov 2001 05:07:25 -0500
Message-ID: <3BF392EF.21CCC234@yahoo.com>
Date: Thu, 15 Nov 2001 05:03:27 -0500
From: Paul Gortmaker <p_gortmaker@yahoo.com>
X-Mailer: Mozilla 3.04 (X11; I; Linux 2.4.14 i586)
MIME-Version: 1.0
To: Dave Jones <davej@suse.de>
CC: Richard Gooch <rgooch@ras.ucalgary.ca>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] mtrr (was Re: GPLONLY kernel symbols???)
In-Reply-To: <Pine.LNX.4.30.0111131439420.4157-100000@Appserv.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Dave Jones wrote:
> 
> On Tue, 13 Nov 2001, Alan Cox wrote:
> 
> > I wasnt aware mtrr.c had an active maintainer.
> 
> Well, hpa and myself are the only ones really maintaining it
> in the last two years judging from the changelog. Some others
> probably also contributed small changes not worthy of an entry.

Another SCNWOAE...

Paul.

--- arch/i386/kernel/mtrr.c~	Tue Nov  6 19:14:03 2001
+++ arch/i386/kernel/mtrr.c	Thu Nov 15 04:58:40 2001
@@ -489,7 +489,6 @@
     case MTRR_IF_INTEL:
 	rdmsr (MTRRcap_MSR, config, dummy);
 	return (config & (1<<10));
-	return 1;
     case MTRR_IF_AMD_K6:
     case MTRR_IF_CENTAUR_MCR:
     case MTRR_IF_CYRIX_ARR:



