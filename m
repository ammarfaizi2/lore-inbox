Return-Path: <linux-kernel-owner+w=401wt.eu-S1750842AbXACPor@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750842AbXACPor (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 10:44:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750838AbXACPor
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 10:44:47 -0500
Received: from smtpq3.groni1.gr.home.nl ([213.51.130.202]:51915 "EHLO
	smtpq3.groni1.gr.home.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750834AbXACPoq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 10:44:46 -0500
Message-ID: <459BCF0E.3020402@gmail.com>
Date: Wed, 03 Jan 2007 16:43:10 +0100
From: Rene Herman <rene.herman@gmail.com>
User-Agent: Thunderbird 1.5.0.9 (X11/20061206)
MIME-Version: 1.0
To: vgoyal@in.ibm.com
CC: Andi Kleen <ak@suse.de>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Morton Andrew Morton <akpm@osdl.org>,
       Fastboot mailing list <fastboot@lists.osdl.org>
Subject: Re: CONFIG_PHYSICAL_ALIGN limited to 4M?
References: <459A3C6E.7060503@gmail.com> <20070103045659.GC17546@in.ibm.com>
In-Reply-To: <20070103045659.GC17546@in.ibm.com>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
X-AtHome-MailScanner-Information: Please contact support@home.nl for more information
X-AtHome-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vivek Goyal wrote:

> Rencetly I have restored back CONFIG_PHYSICAL_START option. That patch
> is still in -mm. IMHO, your case will fit more if we set
> CONFIG_PHYSICAL_START to 16M rather than increasing alignment upper limit
> for CONFIG_PHYSICAL_ALIGN. 
> 
> http://kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.20-rc2/2.6.20-rc2-mm1/broken-out/i386-restore-config_physical_start-option.patch

I agree. That matches the want better.

> Andrew, Can you please push this patch to 2.6.20-rc3?

No objections from me and it merely restores 2.6.19 functionality but 
also no great rush as far as I'm concerned. Can live with applying it 
manually for a release. See Xen was the original restoration reason; 
maybe they really want it in 2.6.20...

Thanks,
Rene

