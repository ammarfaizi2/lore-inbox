Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131210AbRBUFpy>; Wed, 21 Feb 2001 00:45:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131560AbRBUFpo>; Wed, 21 Feb 2001 00:45:44 -0500
Received: from [199.239.160.155] ([199.239.160.155]:21253 "EHLO
	tenchi.datarithm.net") by vger.kernel.org with ESMTP
	id <S131210AbRBUFph>; Wed, 21 Feb 2001 00:45:37 -0500
Date: Tue, 20 Feb 2001 21:45:22 -0800
From: Robert Read <rread@datarithm.net>
To: michaelc <michaelc@turbolinux.com.cn>
Cc: linux-kernel@vger.kernel.org
Subject: Re: can somebody explain how linux support 64G memory
Message-ID: <20010220214522.A5925@tenchi.datarithm.net>
Mail-Followup-To: michaelc <michaelc@turbolinux.com.cn>,
	linux-kernel@vger.kernel.org
In-Reply-To: <544126968.20010221104430@turbolinux.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <544126968.20010221104430@turbolinux.com.cn>; from michaelc@turbolinux.com.cn on Wed, Feb 21, 2001 at 10:44:30AM +0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There are two ways, the PAE flag and the PSE-36 feature introduced in
P3. These extensions are documented in the IA-32 Intel Architecture
Software Developer's Manuals, which you can find here:

http://developer.intel.com/design/Pentium4/manuals/ 

Look in Volume 3, Chapter 3 for this info.

robert


On Wed, Feb 21, 2001 at 10:44:30AM +0800, michaelc wrote:
> Hi,
>    How does linux support more than 4G memory? I 've read the
>    documentation of  Intel IA-32 Architecture, I knew that OS
>    just address up to 4G physical address space, If OS want to
>    access additional 4-GByte section of physical memory, it must
>    change the pointer in register CR3 or entries in the
>    page-directory-pointer table. That means that Linux just has
>    up to 4-GByte page mapping at one time , is that right?
> 
>   
> 
> -- 
> Best regards,
>  michael chen                          mailto:michaelc@turbolinux.com.cn
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
