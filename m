Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129069AbQJ3VWh>; Mon, 30 Oct 2000 16:22:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129104AbQJ3VW1>; Mon, 30 Oct 2000 16:22:27 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:42759 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S129069AbQJ3VWS>; Mon, 30 Oct 2000 16:22:18 -0500
Message-ID: <39FDE553.225113BA@timpanogas.org>
Date: Mon, 30 Oct 2000 14:17:07 -0700
From: "Jeff V. Merkey" <jmerkey@timpanogas.org>
Organization: TRG, Inc.
X-Mailer: Mozilla 4.7 [en] (WinNT; I)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>,
        linux-kernel@vger.kernel.org
Subject: Re: 2.2.18Pre Lan Performance Rocks!
In-Reply-To: <E13qJlo-00077p-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Thanks,

It will make merging the MANOS kernel happen faster.  My DLL prototypes
are using subsets
of Linux 2.2.16 for MANOS at present, and what I really need is for the
support issues to dovetail into a supported effort.  This one might fit
the bill.  I have no desire for TRG to support the 100's of LAN and disk
drivers all by our little lonesome in a divergent code base.

Jeff

Alan Cox wrote:
> 
> > context switches.   profiling Ring 0 Linux vs. NetWare will give me an
> > excellent idea of where
> > the optimizations will need to be inserted.  A straight MARS-NWE port to
> > kernel would just
> > happen, since we would be able to just load in kernel space and run it
> > with no code
> > changes.
> 
> There are one bunch of people running Linux on a flat memory space with no
> protection although their goal was to make Linux run on mmuless embedded
> hardware.
> 
> See www.uclinux.org; the uclinux guys started a 2.4 port recently. Basically
> the idea is to have a mm-nommu/ directory which implements a mostly compatible
> replacement for the mm layer (obviously stuff like mmap dont work without an
> mmu and fork is odd), and a set of binary loaders to load flat binaries with
> relocations.
> 
> That I think is the project that overlaps ..
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
