Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293162AbSCKVsW>; Mon, 11 Mar 2002 16:48:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293196AbSCKVsO>; Mon, 11 Mar 2002 16:48:14 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:25614 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S293162AbSCKVsC>;
	Mon, 11 Mar 2002 16:48:02 -0500
Message-ID: <3C8D25A8.52F46BA4@zip.com.au>
Date: Mon, 11 Mar 2002 13:46:16 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: John Schmerge <schmerge@speakeasy.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: Oops/Crash with 2.4.17 and 2.4.18 kernels
In-Reply-To: <Pine.LNX.4.44.0203110312210.24674-100000@grace.speakeasy.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Schmerge wrote:
> 
> ...
>   Asus CUV4X-D motherboard
>   2 x Pentium III 1.0 ghz processors
>   1024 Mb ram (4x256mb)
>   IBM Deskstar 40gb ata100 disk
>   Radeon QD AGP card
>   Realtek 8139 pci NIC
> 
> ...
> Mar  9 03:46:07 voltaire kernel: Unable to handle kernel paging request at virtual address 04000004

Single-bit error.  Kernel expected either a valid address or a null
pointer, but bit 26 was set.

You should run memtest86 for 24 hours, and be suspicious of your
shiny new hardware :(

-
