Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261654AbVGNTNJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261654AbVGNTNJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 15:13:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263057AbVGNTKa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 15:10:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:38579 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S261688AbVGNTJa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 15:09:30 -0400
Date: Thu, 14 Jul 2005 21:09:29 +0200
From: Andi Kleen <ak@suse.de>
To: "Ronald G. Minnich" <rminnich@lanl.gov>
Cc: yhlu <yinghailu@gmail.com>, Stefan Reinauer <stepan@openbios.org>,
       discuss@x86-64.org, linux-kernel@vger.kernel.org
Subject: Re: [discuss] Re: NUMA support for dual core Opteron
Message-ID: <20050714190929.GL23619@wotan.suse.de>
References: <2ea3fae10507141058c476927@mail.gmail.com> <Pine.LNX.4.58.0507141259170.22630@enigma.lanl.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0507141259170.22630@enigma.lanl.gov>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[closed mailing list dropped. Sorry I have no plans to argue with
your mailbots]

On Thu, Jul 14, 2005 at 01:00:01PM -0600, Ronald G. Minnich wrote:
> if there is any chance of getting along without ACPI entries that is best.  
> Linux did do this once already, for SMP K8: K8 can boot and run NUMA
> without an SRAT table. What more is needed for dual core, and could Linux
> support in this area be extended?

The dual core NUMA parsing problem could be probably fixed. I personally
have no plans to work on it though, since the ACPI method works fine.

Feel free to submit patches.

However with 90+W CPUs I would strongly recommend having support
for PowerNow! and the old style PST table doesn't support
dual core or SMP, so you need ACPI for that anyways.

-Andi
