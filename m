Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286578AbRLUVJ2>; Fri, 21 Dec 2001 16:09:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286577AbRLUVJT>; Fri, 21 Dec 2001 16:09:19 -0500
Received: from dsl254-112-233.nyc1.dsl.speakeasy.net ([216.254.112.233]:32919
	"EHLO snark.thyrsus.com") by vger.kernel.org with ESMTP
	id <S286578AbRLUVJH>; Fri, 21 Dec 2001 16:09:07 -0500
Date: Fri, 21 Dec 2001 15:56:11 -0500
From: "Eric S. Raymond" <esr@thyrsus.com>
To: David Garfield <garfield@irving.iisd.sra.com>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Configure.help editorial policy
Message-ID: <20011221155611.B12127@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	David Garfield <garfield@irving.iisd.sra.com>,
	Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <20011220143247.A19377@thyrsus.com> <15394.29882.361540.200600@irving.iisd.sra.com> <20011220185226.A25080@thyrsus.com> <15395.33489.779730.767039@irving.iisd.sra.com> <20011221134034.B11147@thyrsus.com> <15395.39479.366221.613466@irving.iisd.sra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <15395.39479.366221.613466@irving.iisd.sra.com>; from garfield@irving.iisd.sra.com on Fri, Dec 21, 2001 at 03:23:19PM -0500
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Garfield <garfield@irving.iisd.sra.com>:
> Eric S. Raymond writes:
>  > What, and *encourage* non-uniform terminology?  No, I won't do that.
>  > Better to have a single standard set of abbreviations, no matter how
>  > ugly, than this.
> 
> Valid argument.  I will point out that the current version is
> non-uniform.  Quoting from Configure.help :
> 
> 
> > # Choice: himem
> > High Memory support
> > CONFIG_NOHIGHMEM
> >   Linux can use up to 64 Gigabytes of physical memory on x86 systems.
> >   However, the address space of 32-bit x86 processors is only 4
> >   Gigabytes large. That means that, if you have a large amount of
> >   physical memory, not all of it can be "permanently mapped" by the
> >   kernel. The physical memory that's not permanently mapped is called
> >   "high memory".
> > 
> >   If you are compiling a kernel which will never run on a machine with
> >   more than 960 megabytes of total physical RAM, answer "off" here
> >   (default choice and suitable for most users). This will result in a
> >   "3GiB/1GiB" split: 3GiB are mapped so that each process sees a 3GiB
> >   virtual memory space and the remaining part of the 4GiB virtual memory
> >   space is used by the kernel to permanently map as much physical memory
> >   as possible.
> > 
> >   If the machine has between 1 and 4 Gigabytes physical RAM, then
> >   answer "4GB" here.
> 
> 
> Note "3GiB/1GiB" and "4GB".

Yeah, that's because I can't touch the symbol namespace.  Not yet, anyway.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

He that would make his own liberty secure must guard even his enemy from
oppression: for if he violates this duty, he establishes a precedent that
will reach unto himself.	-- Thomas Paine
