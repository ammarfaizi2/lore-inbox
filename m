Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266416AbUAOCbI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 21:31:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266420AbUAOCbH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 21:31:07 -0500
Received: from as13-5-5.has.s.bonet.se ([217.215.179.23]:41188 "EHLO
	K-7.stesmi.com") by vger.kernel.org with ESMTP id S266416AbUAOCbF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 21:31:05 -0500
Message-ID: <4005FC5D.8030407@stesmi.com>
Date: Thu, 15 Jan 2004 03:35:09 +0100
From: Stefan Smietanowski <stesmi@stesmi.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Randy.Dunlap" <rddunlap@osdl.org>
CC: lkml <linux-kernel@vger.kernel.org>, akpm@osdl.org,
       matthew.e.tolentino@intel.com, Matt_Domsch@dell.com
Subject: Re: [PATCH] EFI zero-page usage (keeping docs updated)
References: <20040114164738.5be4a4a3.rddunlap@osdl.org>
In-Reply-To: <20040114164738.5be4a4a3.rddunlap@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Randy.

> Add x86 EFI zero-page usage to i386 docs.
> 
> Please apply to 2.6.current...
>   0xb0 - 0x1df		Free. Add more parameters here if you really need them.
            ^^^^^
>  
> +0x1c4	unsigned long	EFI system table pointer
> +0x1c8	unsigned long	EFI memory descriptor size
> +0x1cc	unsigned long	EFI memory descriptor version
> +0x1d0	unsigned long	EFI memory descriptor map pointer
> +0x1d4	unsigned long	EFI memory descriptor map size
>  0x1e0	unsigned long	ALT_MEM_K, alternative mem check, in Kb
>  0x1e8	char		number of entries in E820MAP (below)
>  0x1e9	unsigned char	number of entries in EDDBUF (below)

Change that to 0x1c3 instead since it's now used by EFI :)

// Stefan

