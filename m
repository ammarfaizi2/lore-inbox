Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286349AbRLUUY4>; Fri, 21 Dec 2001 15:24:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285129AbRLUUYn>; Fri, 21 Dec 2001 15:24:43 -0500
Received: from aldebaran.sra.com ([163.252.31.31]:54717 "EHLO
	aldebaran.sra.com") by vger.kernel.org with ESMTP
	id <S285128AbRLUUYf>; Fri, 21 Dec 2001 15:24:35 -0500
From: David Garfield <garfield@irving.iisd.sra.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15395.39479.366221.613466@irving.iisd.sra.com>
Date: Fri, 21 Dec 2001 15:23:19 -0500
To: esr@thyrsus.com
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Configure.help editorial policy
In-Reply-To: <20011221134034.B11147@thyrsus.com>
In-Reply-To: <20011220143247.A19377@thyrsus.com>
	<15394.29882.361540.200600@irving.iisd.sra.com>
	<20011220185226.A25080@thyrsus.com>
	<15395.33489.779730.767039@irving.iisd.sra.com>
	<20011221134034.B11147@thyrsus.com>
X-Mailer: VM 6.96 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric S. Raymond writes:
 > What, and *encourage* non-uniform terminology?  No, I won't do that.
 > Better to have a single standard set of abbreviations, no matter how
 > ugly, than this.

Valid argument.  I will point out that the current version is
non-uniform.  Quoting from Configure.help :


> # Choice: himem
> High Memory support
> CONFIG_NOHIGHMEM
>   Linux can use up to 64 Gigabytes of physical memory on x86 systems.
>   However, the address space of 32-bit x86 processors is only 4
>   Gigabytes large. That means that, if you have a large amount of
>   physical memory, not all of it can be "permanently mapped" by the
>   kernel. The physical memory that's not permanently mapped is called
>   "high memory".
> 
>   If you are compiling a kernel which will never run on a machine with
>   more than 960 megabytes of total physical RAM, answer "off" here
>   (default choice and suitable for most users). This will result in a
>   "3GiB/1GiB" split: 3GiB are mapped so that each process sees a 3GiB
>   virtual memory space and the remaining part of the 4GiB virtual memory
>   space is used by the kernel to permanently map as much physical memory
>   as possible.
> 
>   If the machine has between 1 and 4 Gigabytes physical RAM, then
>   answer "4GB" here.


Note "3GiB/1GiB" and "4GB".

--David
