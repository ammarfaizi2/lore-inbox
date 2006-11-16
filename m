Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161830AbWKPRb4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161830AbWKPRb4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 12:31:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161844AbWKPRb4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 12:31:56 -0500
Received: from e31.co.us.ibm.com ([32.97.110.149]:41169 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1161830AbWKPRbz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 12:31:55 -0500
Message-ID: <455CA088.3040807@us.ibm.com>
Date: Thu, 16 Nov 2006 11:31:52 -0600
From: Maynard Johnson <maynardj@us.ibm.com>
Reply-To: maynardj@us.ibm.com
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.3) Gecko/20040910
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Maynard Johnson <maynardj@us.ibm.com>
CC: cbe-oss-dev@ozlabs.org, linuxppc-dev@ozlabs.org,
       oprofile-list@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [RFC, Patch 0/1] OProfile for Cell: Initial profiling support
 -- new	patch
References: <455B60E5.2040201@us.ibm.com>
In-Reply-To: <455B60E5.2040201@us.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Based on review comments received so far, we will be posting an updated 
kernel patch for OProfile for Cell.  Most notably, this patch removes 
some racey conditions between our "virtual counter" function and the 
interrupt handler, as well as fixing the way we were restarting and 
stopping our timer for the virtual counter.

Thanks.
-Maynard

Maynard Johnson wrote:

> Hello,
> I will be posting a patch that updates the OProfile kernel driver to 
> enable it for the Cell Broadband Engine processor.  The patch is based 
> on Arnd Bergmann's arnd6 patchset for 2.6.18  
> (http://kernel.org/pub/linux/kernel/people/arnd/patches/2.6.18-arnd6/), 
> with Kevin Corry's cbe_pmu_interrupt patch on applied on top.  Kevin 
> Corry's patch was submitted to the mailing lists earlier today and can 
> be found at:
>  http://marc.theaimsgroup.com/?l=linux-kernel&m=116360639928471&w=2).
> 
> I will also post an OProfile userpsace patch to the oprofile-list that 
> adds the necessary support for the Cell processor.
> 
> Thanks in advance for your review of this patch.
> 
> Maynard Johnson
> LTC Power Linux Toolchain
> 507-253-2650
> 
> 
> -------------------------------------------------------------------------
> Take Surveys. Earn Cash. Influence the Future of IT
> Join SourceForge.net's Techsay panel and you'll get the chance to share your
> opinions on IT & business topics through brief surveys - and earn cash
> http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
> _______________________________________________
> oprofile-list mailing list
> oprofile-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/oprofile-list


