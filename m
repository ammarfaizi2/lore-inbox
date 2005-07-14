Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261682AbVGNSuJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261682AbVGNSuJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 14:50:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263082AbVGNSuG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 14:50:06 -0400
Received: from mx1.suse.de ([195.135.220.2]:914 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S261682AbVGNSsX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 14:48:23 -0400
Date: Thu, 14 Jul 2005 20:48:21 +0200
From: Andi Kleen <ak@suse.de>
To: Li-Ta Lo <ollie@lanl.gov>
Cc: yhlu <yinghailu@gmail.com>, "Ronald G. Minnich" <rminnich@lanl.gov>,
       Stefan Reinauer <stepan@openbios.org>, discuss@x86-64.org,
       LinuxBIOS <linuxbios@openbios.org>, linux-kernel@vger.kernel.org
Subject: Re: [discuss] Re: [LinuxBIOS] NUMA support for dual core Opteron
Message-ID: <20050714184821.GJ23619@wotan.suse.de>
References: <2ea3fae10507141058c476927@mail.gmail.com> <1121365786.3317.6.camel@logarithm.lanl.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1121365786.3317.6.camel@logarithm.lanl.gov>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> AFIAK, for x86_64 kernel, it will try to read NUMA configuration from
> HW directory. We don't have to export any ACPI table.

It doesn't work for dual core or 8 sockets for some reason. Since the SRAT
code works fine and is in general more future proof we never tracked down 
why. Patches welcome. 

However you'll likely need ACPI for other reasons anyways, e.g. for
better power saving.

-Andi

