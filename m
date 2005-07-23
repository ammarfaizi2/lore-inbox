Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261785AbVGWQUV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261785AbVGWQUV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Jul 2005 12:20:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262066AbVGWQUV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Jul 2005 12:20:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:54402 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S261785AbVGWQUG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Jul 2005 12:20:06 -0400
To: Francois Pepin <fpepin@aei.ca>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel oops with x64_86 crossing 4Gb boundary
References: <1121901528.5121.21.camel@elm.mcb.mcgill.ca.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 23 Jul 2005 18:20:03 +0200
In-Reply-To: <1121901528.5121.21.camel@elm.mcb.mcgill.ca.suse.lists.linux.kernel>
Message-ID: <p737jfhbiks.fsf@bragg.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Francois Pepin <fpepin@aei.ca> writes:

> Hi,
> 
> I am getting pseudo-random kernel oops on my Opteron box (Tyan Thunder
> K8W) with 4Gb RAM. I am running RedHad FC3 with kernel
> 2.6.11-1.35_FC3smp.
> 
> It runs well with default BIOS settings, but only 3.5Gb RAM are visible.
> Using the "Software Memory Hole" option in the BIOS (version 3.02)
> remaps the last 2Gb to 4-6Gb. This causes kernel oops with various
> applications, generally killing them.
> 
> I can reproduce it by loading lots of data into R (which caused the oops
> below). Various other applications have caused it

Software memory hole is broken in the BIOS. Don't use it.

-Andi

