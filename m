Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263176AbVGOCqu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263176AbVGOCqu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 22:46:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263181AbVGOCqu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 22:46:50 -0400
Received: from wproxy.gmail.com ([64.233.184.197]:62012 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S263176AbVGOCqt convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 22:46:49 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=eHE77IxNRC8sMzvMz0r0s+DgpKIWo36mqc8+YCqSuTQEfm8ruF0HNYWQwa4hZcxLlIq628fNzDRJTkTOal7B/gu/3m/bBLHD5r0U1u1Scd92yJvlCAdjkxnb0QWuzO8sUSkvqdKTWBG4EqtWIbmVmp9okvDgy4NVLV+6zmT0HNo=
Message-ID: <2ea3fae1050714194649c66d7e@mail.gmail.com>
Date: Thu, 14 Jul 2005 19:46:49 -0700
From: yhlu <yinghailu@gmail.com>
Reply-To: yhlu <yinghailu@gmail.com>
To: Andi Kleen <ak@suse.de>
Subject: Re: [discuss] Re: NUMA support for dual core Opteron
Cc: "Ronald G. Minnich" <rminnich@lanl.gov>,
       Stefan Reinauer <stepan@openbios.org>, discuss@x86-64.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20050714190929.GL23619@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <2ea3fae10507141058c476927@mail.gmail.com>
	 <Pine.LNX.4.58.0507141259170.22630@enigma.lanl.gov>
	 <20050714190929.GL23619@wotan.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I didn't see any problem about NUMA with LinuxBIOS + 8way dual core system.
of couse the acpi support in Kernel is disabled.

p.s. can you use powernow when acpi is disabled?
p.s.s  Is powerpc64 support ACPI? or ACPI is only can be used by x86?

YH

On 7/14/05, Andi Kleen <ak@suse.de> wrote:
> [closed mailing list dropped. Sorry I have no plans to argue with
> your mailbots]
> 
> On Thu, Jul 14, 2005 at 01:00:01PM -0600, Ronald G. Minnich wrote:
> > if there is any chance of getting along without ACPI entries that is best.
> > Linux did do this once already, for SMP K8: K8 can boot and run NUMA
> > without an SRAT table. What more is needed for dual core, and could Linux
> > support in this area be extended?
> 
> The dual core NUMA parsing problem could be probably fixed. I personally
> have no plans to work on it though, since the ACPI method works fine.
> 
> Feel free to submit patches.
> 
> However with 90+W CPUs I would strongly recommend having support
> for PowerNow! and the old style PST table doesn't support
> dual core or SMP, so you need ACPI for that anyways.
> 
> -Andi
>
