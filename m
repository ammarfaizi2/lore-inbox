Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261547AbVAGTez@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261547AbVAGTez (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 14:34:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261535AbVAGTaU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 14:30:20 -0500
Received: from colin2.muc.de ([193.149.48.15]:11786 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S261553AbVAGT3b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 14:29:31 -0500
Date: 7 Jan 2005 20:29:30 +0100
Date: Fri, 7 Jan 2005 20:29:30 +0100
From: Andi Kleen <ak@muc.de>
To: YhLu <YhLu@tyan.com>
Cc: Matt Domsch <Matt_Domsch@dell.com>, linux-kernel@vger.kernel.org,
       discuss@x86-64.org, jamesclv@us.ibm.com, suresh.b.siddha@intel.com
Subject: Re: 256 apic id for amd64
Message-ID: <20050107192930.GB6518@muc.de>
References: <3174569B9743D511922F00A0C943142307291311@TYANWEB>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3174569B9743D511922F00A0C943142307291311@TYANWEB>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 07, 2005 at 10:27:05AM -0800, YhLu wrote:
> Also in arch/x86_64/kernel/setup.c  init_amd
> 
> 
>         if (c->cpuid_level >= 0x80000008) {
> 
> ---->
> 
>         n = cpuid_eax(0x80000000);
> 
>         if (n >= 0x80000008) {
> 
> for c->cupid_level is get cupid_eax(0) and it always =1

This is already fixed in mainline.

-Andi
