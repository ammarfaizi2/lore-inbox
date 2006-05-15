Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964784AbWEOHWc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964784AbWEOHWc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 03:22:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964785AbWEOHWc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 03:22:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:48011 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S964784AbWEOHWb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 03:22:31 -0400
From: Andi Kleen <ak@suse.de>
To: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
Subject: Re: [PATCH] i386/x86-64 Add nmi watchdog support for new Intel CPUs
Date: Mon, 15 May 2006 09:22:25 +0200
User-Agent: KMail/1.9.1
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>
References: <20060514185023.A16695@unix-os.sc.intel.com>
In-Reply-To: <20060514185023.A16695@unix-os.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605150922.25511.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 15 May 2006 03:50, Venkatesh Pallipadi wrote:

> 
> Intel now has support for Architectural Performance Monitoring Counters
> ( Refer to IA-32 Intel Architecture Software Developer's Manual
> http://www.intel.com/design/pentium4/manuals/253669.htm ). This
> feature is present starting from Intel Core Duo and Intel Core Solo processors.

Nice!
 
> What this means is, the performance monitoring counters and some performance
> monitoring events are now defined in an architectural way (using cpuid).
> And there will be no need to check for family/model etc for these architectural
> events.
> 
> Below is the patch to use this performance counters in nmi watchdog driver.
> Patch handles both i386 and x86-64 kernels.

Can you regenerate it against the latest firstfloor tree please? 
With Don's x86-64 NMI changes there are a zillion rejects.

-Andi
