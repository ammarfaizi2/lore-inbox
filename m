Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752261AbWKCIZn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752261AbWKCIZn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Nov 2006 03:25:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752255AbWKCIZn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Nov 2006 03:25:43 -0500
Received: from mga07.intel.com ([143.182.124.22]:34202 "EHLO
	azsmga101.ch.intel.com") by vger.kernel.org with ESMTP
	id S1752021AbWKCIZm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Nov 2006 03:25:42 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,383,1157353200"; 
   d="scan'208"; a="140450079:sNHT30721488"
Message-ID: <454AFD01.4080306@linux.intel.com>
Date: Fri, 03 Nov 2006 11:25:37 +0300
From: Alexey Starikovskiy <alexey_y_starikovskiy@linux.intel.com>
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
MIME-Version: 1.0
To: Dave Jones <davej@redhat.com>, Adrian Bunk <bunk@stusta.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-acpi@vger.kernel.org, Christian <christiand59@web.de>
Subject: Re: [discuss] Linux 2.6.19-rc4: known unfixed regressions (v2)
References: <Pine.LNX.4.64.0610302019560.25218@g5.osdl.org> <20061103024132.GG13381@stusta.de> <20061103025623.GB8816@redhat.com>
In-Reply-To: <20061103025623.GB8816@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Could this be a problem?
--------------------
...
CONFIG_ACPI_PROCESSOR=m
...
CONFIG_X86_POWERNOW_K8=y
...

Regards,
	Alex.

Dave Jones wrote:
> On Fri, Nov 03, 2006 at 03:41:32AM +0100, Adrian Bunk wrote:
>  > This email lists some known regressions in 2.6.19-rc4 compared to 2.6.18
>  > that are not yet fixed in Linus' tree.
>  > 
>  > If you find your name in the Cc header, you are either submitter of one
>  > of the bugs, maintainer of an affectected subsystem or driver, a patch
>  > of you caused a breakage or I'm considering you in any other way possibly
>  > involved with one or more of these issues.
>  > 
>  > Due to the huge amount of recipients, please trim the Cc when answering.
>  > 
>  > Subject    : cpufreq not working on AMD K8
>  > References : http://lkml.org/lkml/2006/10/10/114
>  > Submitter  : Christian <christiand59@web.de>
>  > Status     : unknown
> 
> As Mark mentioned in his followup, powernow-k8 didn't change in .19 at all.
> I'm suspecting an ACPI change meant that we no longer find the PST tables
> correctly.
> 
> Christian, can you post the full dmesg's from the working/broken kernels.
> It may be useful to enable CONFIG_ACPI_DEBUG too.
> 
> 	Dave
> 
