Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750966AbWEITdi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750966AbWEITdi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 15:33:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750970AbWEITdi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 15:33:38 -0400
Received: from nommos.sslcatacombnetworking.com ([67.18.224.114]:1529 "EHLO
	nommos.sslcatacombnetworking.com") by vger.kernel.org with ESMTP
	id S1750965AbWEITdh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 15:33:37 -0400
In-Reply-To: <20060505172847.GC6450@in.ibm.com>
References: <20060505172847.GC6450@in.ibm.com>
Mime-Version: 1.0 (Apple Message framework v749.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <2C184B1B-9F70-4175-B90B-A1CC5741A6DE@kernel.crashing.org>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Greg KH <gregkh@suse.de>, Morton Andrew Morton <akpm@osdl.org>
Content-Transfer-Encoding: 7bit
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [RFC][PATCH 1/6] kconfigurable resources core changes
Date: Tue, 9 May 2006 14:33:48 -0500
To: vgoyal@in.ibm.com
X-Mailer: Apple Mail (2.749.3)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - nommos.sslcatacombnetworking.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - kernel.crashing.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On May 5, 2006, at 12:28 PM, Vivek Goyal wrote:

>
>
> o Core changes for Kconfigurable memory and IO resources. By  
> default resources
>   are 64bit until chosen to be 32bit.
>
> o Last time I posted the patches for 64bit memory resources but it  
> raised
>   the concerns regarding code bloat on 32bit systems who use 32 bit
>   resources.
>
> o This patch-set allows resources to be kconfigurable.
>
> o I have done cross compilation on i386, x86_64, ppc, powerpc,  
> sparc, sparc64
>   ia64 and alpha.
>
> Signed-off-by: Vivek Goyal <vgoyal@in.ibm.com>
> ---

[snip]

I didn't think the bloat was a big issue based on the numbers you  
reported.  I'd still prefer to see us just move to a 64-bit resource  
on all systems.

- k

