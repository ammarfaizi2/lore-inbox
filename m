Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261261AbVFNRQo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261261AbVFNRQo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Jun 2005 13:16:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261260AbVFNRQo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Jun 2005 13:16:44 -0400
Received: from mail00hq.adic.com ([63.81.117.10]:43839 "EHLO mail00hq.adic.com")
	by vger.kernel.org with ESMTP id S261261AbVFNRQm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Jun 2005 13:16:42 -0400
Message-ID: <42AF10F8.1080601@xfs.org>
Date: Tue, 14 Jun 2005 12:16:40 -0500
From: Steve Lord <lord@xfs.org>
User-Agent: Mozilla Thunderbird 1.0.2-1.3.3 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@muc.de>
CC: "K.R. Foley" <kr@cybsft.com>, pozsy@uhulinux.hu,
       linux-kernel@vger.kernel.org, rusty@rustcorp.com.au
Subject: Re: Race condition in module load causing undefined symbols
References: <42A99D9D.7080900@xfs.org> <20050610112515.691dcb6e.akpm@osdl.org>	<20050611082642.GB17639@ojjektum.uhulinux.hu>	<42AAE5C8.9060609@xfs.org>	<20050611150525.GI17639@ojjektum.uhulinux.hu>	<42AB25E7.5000405@xfs.org> <20050611120040.084942ed.akpm@osdl.org>	<42AEDCFB.8080002@xfs.org> <42AEF979.2000207@cybsft.com>	<42AF080A.1000307@xfs.org> <m14qc0c1xl.fsf@muc.de>
In-Reply-To: <m14qc0c1xl.fsf@muc.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 14 Jun 2005 17:16:41.0176 (UTC) FILETIME=[D4ABBD80:01C57104]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> Steve Lord <lord@xfs.org> writes:
> 
>>So is this some P4 specific optimization which is not working as
>>intended?
> 
> 
> The only pentium specific optimizations that are enabled by MPENTIUM4
> is to tell the compiler to compile for pentium4 and a few settings
> in arch/i386/Kconfig.
> 
> You could enable/disable these individually and see if you can track
> it down with a binary search.
> 
> Most of this stuff should be fairly harmless though and be only
> microoptimizations; I cannot see how they should cause user visible
> races.
> 
> -Andi
> 

I see what you mean about there not being a lot of difference
between the two, however, the other difference between the builds
would be -mtune=pentium3 and -mtune=pentium4.

Steve

