Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932423AbWBAMLM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932423AbWBAMLM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 07:11:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932425AbWBAMLL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 07:11:11 -0500
Received: from cantor2.suse.de ([195.135.220.15]:21938 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932423AbWBAMLK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 07:11:10 -0500
Message-ID: <43E0A55C.6020700@renninger.de>
Date: Wed, 01 Feb 2006 13:11:08 +0100
From: Thomas Renninger <mail@renninger.de>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050715)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dave Jones <davej@redhat.com>
Cc: linux-kernel@vger.kernel.org, mm-commits@vger.kernel.org
Subject: Re: + cpufreq-_ppc-frequency-change-issues-freq-already-lowered-by-bios.patch
 added to -mm tree
References: <200601312112.k0VLCRdV031988@shell0.pdx.osdl.net> <20060131223115.GF29937@redhat.com>
In-Reply-To: <20060131223115.GF29937@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:
> On Tue, Jan 31, 2006 at 01:14:32PM -0800, Andrew Morton wrote:
>  > 
>  > The patch titled
>  > 
>  >      cpufreq: _PPC frequency change issues - freq already lowered by BIOS
>  > 
>  > has been added to the -mm tree.  Its filename is
>  > 
>  >      cpufreq-_ppc-frequency-change-issues-freq-already-lowered-by-bios.patch
>  > 
>  > See http://www.zip.com.au/~akpm/linux/patches/stuff/added-to-mm.txt to find
>  > out what to do about this
>  > 
> 
> *puzzled look*
> 
> I merged this into cpufreq-git last week.
> 
> diff-tree 0961dd0... (from c70ca00...)
> Author: Thomas Renninger <trenn@suse.de>
> Date:   Thu Jan 26 18:46:33 2006 +0100
> 
>     [CPUFREQ] _PPC frequency change issues
> 
> 
> 
> Did your pull fail for some reason? 
> 
> 		Dave

I got this answer from Andrew, maybe he also picked up the patch
from cpufreq list?:
____________
This generates 100% rejects against the current cpufreq tree.  I'd suggest
that you prepare patches against latest -mm, which includes
git-cpufreq.patch.

Please also include the required Signed-off-by: tags, as per section 11 of
Documentation/SubmittingPatches.
____________

The patch needs a (!policy->cur) check for some cpufreq drivers, shall I resend
the whole patch with this one added or is the "ontop" patch I answered to 
avuton@gmail.com (Subject: Re: [PATCH 2/2] Re: 2.6.16-rc1-mm4) enough?

     Thomas
