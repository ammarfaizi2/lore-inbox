Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268992AbRHBPNk>; Thu, 2 Aug 2001 11:13:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269001AbRHBPNa>; Thu, 2 Aug 2001 11:13:30 -0400
Received: from h-207-228-73-44.gen.cadvision.com ([207.228.73.44]:14095 "EHLO
	mobilix.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S268992AbRHBPNZ>; Thu, 2 Aug 2001 11:13:25 -0400
Date: Thu, 2 Aug 2001 09:13:23 -0600
Message-Id: <200108021513.f72FDNZ18683@mobilix.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: dougg@torque.net (Douglas Gilbert), linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org
Subject: Re: [RFT] Support for ~2144 SCSI discs
In-Reply-To: <E15SK4x-0000qB-00@the-village.bc.nu>
In-Reply-To: <no.id>
	<E15SK4x-0000qB-00@the-village.bc.nu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox writes:
> > I've seen GFP_KERNEL take 10 minutes in lk 2.4.6 . The 
> > mm gets tweaked pretty often so it is difficult to know 
> > exactly how it will react when memory is tight. A time 
> > bound would be useful on GFP_KERNEL.
> 
> kmalloc with GFP_KERNEL has a 128K limit which avoids the bizarre
> behaviour you get when you abuse get_free_pages.

Last I heard, get_free_pages() also has a 128 kiB limit. So what's the
difference?

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
