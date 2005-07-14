Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263075AbVGNS3u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263075AbVGNS3u (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 14:29:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263076AbVGNS3u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 14:29:50 -0400
Received: from mailwasher.lanl.gov ([192.65.95.54]:46233 "EHLO
	mailwasher-b.lanl.gov") by vger.kernel.org with ESMTP
	id S263075AbVGNS3u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 14:29:50 -0400
Subject: Re: [LinuxBIOS] NUMA support for dual core Opteron
From: Li-Ta Lo <ollie@lanl.gov>
To: yhlu <yinghailu@gmail.com>
Cc: "Ronald G. Minnich" <rminnich@lanl.gov>,
       Stefan Reinauer <stepan@openbios.org>, discuss@x86-64.org,
       LinuxBIOS <linuxbios@openbios.org>, linux-kernel@vger.kernel.org
In-Reply-To: <2ea3fae10507141058c476927@mail.gmail.com>
References: <2ea3fae10507141058c476927@mail.gmail.com>
Content-Type: text/plain
Organization: Los Alamos National Lab
Date: Thu, 14 Jul 2005 12:29:46 -0600
Message-Id: <1121365786.3317.6.camel@logarithm.lanl.gov>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
X-PMX-Version: 4.7.1.128075
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-07-14 at 10:58 -0700, yhlu wrote:
> Someone mentioned that NUMA support for dual core opteron need acpi
> support in LinuxBIOS.
> 
> there may be some other solution for that.
> 1. PowerPC already support dual core and it should support NUMA, So
> the Open Firmware must have some NUMA entry definition.
> Can we make x86-64 kernel support OpenFirmware interface so we can use
> OpenBIOS as payload of LinuxBIOS.
> 2. enable acpi and add the NUMA entries into it, the Linux Kernel will be happy.
> 3. If we are trying to use ADLO to load Windows/Solaris/FreeBSD, We
> need to pass related acpi info to ADLO....
> 
> Solution 1 will be ideal one, and can make Solaris for X86-64 use
> OpenFirmware interface too.....
> 
> which one is better?
> 


AFIAK, for x86_64 kernel, it will try to read NUMA configuration from
HW directory. We don't have to export any ACPI table.

-- 
Li-Ta Lo <ollie@lanl.gov>
Los Alamos National Lab

