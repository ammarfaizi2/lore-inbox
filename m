Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261591AbVAZXWw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261591AbVAZXWw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jan 2005 18:22:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261583AbVAZXVO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jan 2005 18:21:14 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:36046 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S261591AbVAZSKd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jan 2005 13:10:33 -0500
Date: Wed, 26 Jan 2005 09:53:39 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Dave Hansen <haveblue@us.ibm.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-mm <linux-mm@kvack.org>
Subject: Re: [RFC][PATCH 0/5] consolidate i386 NUMA init code
Message-ID: <2410000.1106762019@flay>
In-Reply-To: <1106762509.6093.67.camel@localhost>
References: <1106698985.6093.39.camel@localhost>  <15640000.1106750236@flay> <1106762509.6093.67.camel@localhost>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Built on all the i386 configs here:
> http://sr71.net/patches/2.6.11/2.6.11-rc1-mm1-mhp1/configs/
> 
> Booted on x440 (summit and generic), numaq, 4-way PIII.  I would imagine
> that any problem would manifest as the system simply not booting.  The
> most likely to fail would be systems with DISCONTIG enabled, because
> that's where the greatest amount of churn happened.  The normal !
> DISCONTIG case still uses most of the same code.
> 
> Anyway, I think they're probably ready for a run in -mm, with the "if
> the machines don't boot check these first" flag set.  Although, I'd
> appreciate any other testing that anyone wants to throw at them.

Yup, as long as they boot, is probably good enough for now.

Thanks,

M.

