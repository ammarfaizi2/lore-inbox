Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750928AbWDEEdb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750928AbWDEEdb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Apr 2006 00:33:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751100AbWDEEdb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Apr 2006 00:33:31 -0400
Received: from nommos.sslcatacombnetworking.com ([67.18.224.114]:43620 "EHLO
	nommos.sslcatacombnetworking.com") by vger.kernel.org with ESMTP
	id S1750928AbWDEEdb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Apr 2006 00:33:31 -0400
In-Reply-To: <20060405130553.3240e5ea.sfr@canb.auug.org.au>
References: <Pine.LNX.4.44.0604041612320.30113-100000@gate.crashing.org> <20060405102837.66b44c43.sfr@canb.auug.org.au> <1E1C6A02-5C4D-4A3A-8483-8D5E2773680B@kernel.crashing.org> <20060405130553.3240e5ea.sfr@canb.auug.org.au>
Mime-Version: 1.0 (Apple Message framework v746.3)
X-Gpgmail-State: !signed
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <426751E3-A5CA-4656-B9CC-3D3F19375B32@kernel.crashing.org>
Cc: paulus@samba.org, linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: Please pull from 'for_paulus' branch of powerpc
Date: Tue, 4 Apr 2006 23:33:52 -0500
To: Stephen Rothwell <sfr@canb.auug.org.au>
X-Mailer: Apple Mail (2.746.3)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - nommos.sslcatacombnetworking.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - kernel.crashing.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Apr 4, 2006, at 10:05 PM, Stephen Rothwell wrote:

> Hi Kumar,
>
> On Tue, 4 Apr 2006 20:23:23 -0500 Kumar Gala  
> <galak@kernel.crashing.org> wrote:
>>
>> We need the irq rework before I'd be willing to do this.  The main
>> dependancy between asm-ppc and asm-powerpc is the static IRQs we
>> currently have.  I'd rather spend time on fixing up the IRQ handling
>> to parse the flat dev tree.
>
> I agree entirely.  To clrify, I was referring to header files that  
> only
> exist in include/asm-ppc and are trivial to move.
>
> Patches following ...

Agreed.

- k
