Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261836AbVBJWNU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261836AbVBJWNU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Feb 2005 17:13:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261868AbVBJWNU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Feb 2005 17:13:20 -0500
Received: from sccrmhc12.comcast.net ([204.127.202.56]:37576 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S261836AbVBJWNP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Feb 2005 17:13:15 -0500
Message-ID: <420BDC7A.10402@acm.org>
Date: Thu, 10 Feb 2005 16:13:14 -0600
From: Corey Minyard <minyard@acm.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-rc3-mm2
References: <20050210023508.3583cf87.akpm@osdl.org>
In-Reply-To: <20050210023508.3583cf87.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.11-rc3/2.6.11-rc3-mm2/
>
>
>- Added the mlock and !SCHED_OTHER Linux Security Module for the audio guys.
>  It seems that nothing else is going to come along and this is completely
>  encapsulated.
>
>- Various other stuff.  If anyone has a patch in here which they think
>  should be in 2.6.11, please let me know.  I'm intending to merge the
>  following into 2.6.11:
>
>	alpha-add-missing-dma_mapping_error.patch
>	fix-compat-shmget-overflow.patch
>	fix-shmget-for-ppc64-s390-64-sparc64.patch
>	binfmt_elf-clearing-bss-may-fail.patch
>	qlogic-warning-fixes.patch
>	oprofile-exittext-referenced-in-inittext.patch
>	force-read-implies-exec-for-all-32bit-processes-in-x86-64.patch
>	oprofile-arm-xscale1-pmu-support-fix.patch
>
>
>  
>
The following one should probably go in:

>+update-to-ipmi-driver-to-support-old-dmi-spec.patch
>  
>
Systems with old data will not work correctly without it.  There seems 
to be a few of them out there.

-Corey
