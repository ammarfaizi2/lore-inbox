Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261523AbTBSVJg>; Wed, 19 Feb 2003 16:09:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261527AbTBSVJf>; Wed, 19 Feb 2003 16:09:35 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:40402 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S261523AbTBSVJe>; Wed, 19 Feb 2003 16:09:34 -0500
Date: Wed, 19 Feb 2003 13:08:06 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: gone@us.ibm.com, akpm@zip.com.au
cc: linux-kernel@vger.kernel.org, andrew.grover@intel.com
Subject: Re: [PATCH] (2/2) x440 discontig support on 2.5.62: disco
Message-ID: <74440000.1045688886@flay>
In-Reply-To: <200302190307.h1J37WE25499@w-gaughen.beaverton.ibm.com>
References: <200302190307.h1J37WE25499@w-gaughen.beaverton.ibm.com>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This patch provides discontigmem support for the IBM x440 against 2.5.62.
> I  sent this patch to the list last week as an [RFC], and have resolved
> the  feedback received. This code has passed through the hands of several 
> developers:  Chandra Seetharaman, James Cleverdon, John Stultz, and last
> to  touch it, me :-)  It also includes code for correctly figuring out
> zholes_size  written by Andy Whitcroft (posted to lkml today).
> 
> This patch depends on the early, early ioremap patch.  It also requires
> full  acpi support, but to boot the user needs to specify acpi=off at the
> boot  prompt, until Andy Grover's acpi patch for the x440 is merged in.

Cool - that looks much better ... all the major issues with it seem to
be fixed.

M.

