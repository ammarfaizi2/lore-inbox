Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271588AbRHUIDa>; Tue, 21 Aug 2001 04:03:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271589AbRHUIDU>; Tue, 21 Aug 2001 04:03:20 -0400
Received: from mail6.svr.pol.co.uk ([195.92.193.212]:32356 "EHLO
	mail6.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S271588AbRHUIDN>; Tue, 21 Aug 2001 04:03:13 -0400
Date: Tue, 21 Aug 2001 09:03:02 +0100
From: kernel@corrosive.freeserve.co.uk
To: linux-kernel@vger.kernel.org
Cc: jhartmann@precisioninsight.com
Subject: Re: SiS 735 chipset
Message-ID: <20010821090302.B2559@corrosive.freeserve.co.uk>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	jhartmann@precisioninsight.com
In-Reply-To: <0107102112300E.07809@movitslinux.bloomberg.com> <20010817084939.A873@corrosive.freeserve.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010817084939.A873@corrosive.freeserve.co.uk>
User-Agent: Mutt/1.3.20i
X-Operating-System: Linux corrosive.freeserve.co.uk 2.4.8-ac7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 17, 2001 at 08:49:40AM +0100, kernel@corrosive.freeserve.co.uk wrote:
> The AGP can also be made to work by using 'agp_try_unsupported=1' as a
> module/kernel argument.  I'm currently updated the PCI.IDS file and the known
> AGP chipset list to include the 735, but I'm checking that the AGP works
> fully first.

Hi,
I've attached the patch that lets the kernel SIS AGP driver recognise the 735
chipset as it seems fine.  I don't know of any system for testing the AGP
support so I tried QuakeIII and that ran fine.  The patch is against 2.4.8-ac4
but since all it changes is a couple of (infrequently) changed tables it should
work fine on later versions.  I've CC'd Jeff Hartmann with it as he seems to
be the maintainer of the AGP side (but isn't listed in the MAINTAINERS file).

Cheers,
Adrian.
