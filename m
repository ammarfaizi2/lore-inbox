Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289074AbSAGBpZ>; Sun, 6 Jan 2002 20:45:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289076AbSAGBpQ>; Sun, 6 Jan 2002 20:45:16 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:53778 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S289074AbSAGBpC>; Sun, 6 Jan 2002 20:45:02 -0500
Message-ID: <3C38FD84.3020207@zytor.com>
Date: Sun, 06 Jan 2002 17:44:36 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en-us, en, sv
MIME-Version: 1.0
To: Richard Gooch <rgooch@ras.ucalgary.ca>
CC: Matt Dainty <matt@bodgit-n-scarper.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, torvalds@transmeta.com
Subject: Re: [PATCH] DevFS support for /dev/cpu/X/(cpuid|msr)
In-Reply-To: <20020106181749.A714@butterlicious.bodgit-n-scarper.com>	<200201061934.g06JYnZ15633@vindaloo.ras.ucalgary.ca>	<3C38BC6B.7090301@zytor.com>	<200201062108.g06L8lM17189@vindaloo.ras.ucalgary.ca>	<3C38BD32.6000900@zytor.com>	<200201070131.g071VrM20956@vindaloo.ras.ucalgary.ca>	<3C38FAB0.4000503@zytor.com> <200201070140.g071ewk21192@vindaloo.ras.ucalgary.ca>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard Gooch wrote:

> 
> Unfortunately, there doesn't seem to be a really nice place to put
> generic SMP startup code. Each arch defines it's own per-cpu startup
> code. As Matt asked in a private email, it would require hacks to each
> arch to support this (Matt: this is my reply:-). While it would be
> fairly simple to add a call to a devfs_cpu_register() function to each
> arch, this does seem a bit hackish.
> 
> So I'd like to propose a new file (say kernel/smp.c) which has generic
> startup code for each CPU. To start with, it can have a
> generic_cpu_init() function, which is called by each arch. Note that
> this function would be called for the boot CPU too.
> 


Makes sense.

	-hpa


