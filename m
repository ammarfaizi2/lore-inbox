Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311302AbSCLSGU>; Tue, 12 Mar 2002 13:06:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311303AbSCLSGB>; Tue, 12 Mar 2002 13:06:01 -0500
Received: from grace.speakeasy.org ([216.254.0.2]:29962 "HELO
	grace.speakeasy.org") by vger.kernel.org with SMTP
	id <S311302AbSCLSF7>; Tue, 12 Mar 2002 13:05:59 -0500
Date: Tue, 12 Mar 2002 10:05:58 -0800 (PST)
From: John Schmerge <schmerge@speakeasy.net>
To: Andrew Morton <akpm@zip.com.au>
cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Oops/Crash with 2.4.17 and 2.4.18 kernels
In-Reply-To: <3C8D25A8.52F46BA4@zip.com.au>
Message-ID: <Pine.LNX.4.44.0203121005060.13438-100000@grace.speakeasy.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the insight... It turns out that you're conjecture seems to be
correct. Boy, I feel like a n00b... I had run memtest86 after first noticing
these problems and everything seemed ok, but after a good long run last night,
I started to see the failures. Sigh. Looks like i have either a bad mobo or a
bad processor.

Thanks again,
John

On Mon, 11 Mar 2002, Andrew Morton wrote:

> John Schmerge wrote:
> > 
> > ...
> >   Asus CUV4X-D motherboard
> >   2 x Pentium III 1.0 ghz processors
> >   1024 Mb ram (4x256mb)
> >   IBM Deskstar 40gb ata100 disk
> >   Radeon QD AGP card
> >   Realtek 8139 pci NIC
> > 
> > ...
> > Mar  9 03:46:07 voltaire kernel: Unable to handle kernel paging request at virtual address 04000004
> 
> Single-bit error.  Kernel expected either a valid address or a null
> pointer, but bit 26 was set.
> 
> You should run memtest86 for 24 hours, and be suspicious of your
> shiny new hardware :(
> 
> -
> 

