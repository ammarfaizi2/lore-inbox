Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129124AbRBIFfx>; Fri, 9 Feb 2001 00:35:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130056AbRBIFfn>; Fri, 9 Feb 2001 00:35:43 -0500
Received: from [193.120.224.170] ([193.120.224.170]:55949 "EHLO
	florence.itg.ie") by vger.kernel.org with ESMTP id <S129124AbRBIFfl>;
	Fri, 9 Feb 2001 00:35:41 -0500
Date: Fri, 9 Feb 2001 05:35:36 +0000 (GMT)
From: Paul Jakma <paulj@itg.ie>
To: Alex Deucher <adeucher@UU.NET>
cc: Petr Vandrovec <VANDROVE@vc.cvut.cz>, <linux-kernel@vger.kernel.org>,
        <jhartmann@valinux.com>
Subject: Re: [OT] Re: 2.4.x, drm, g400 and pci_set_master
In-Reply-To: <Pine.LNX.4.32.0102090448300.3757-100000@rossi.itg.ie>
Message-ID: <Pine.LNX.4.32.0102090530120.3757-100000@rossi.itg.ie>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

replying to myself..

On Fri, 9 Feb 2001, Paul Jakma wrote:

> why put in mga specific code?

last time i asked why 2x74x hardware iommu wasn't supported i was told
something along the lines of cause generic kernel driver interfaces
wouldn't support it. so support for the alpha hardware would require
changing certain global interfaces (and all the drivers using them).

so for the short-term i guess you will have to implement a dri-local
hack.  However for the 2x17x boards you could make use of the IOMMU
and at least prove the usefullness of it. (and a speed benefit.)

--paulj

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
