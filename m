Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130006AbRAWR74>; Tue, 23 Jan 2001 12:59:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129776AbRAWR7q>; Tue, 23 Jan 2001 12:59:46 -0500
Received: from beton.vrvis.at ([194.152.163.92]:42759 "EHLO beton.vrvis.at")
	by vger.kernel.org with ESMTP id <S130749AbRAWR7h>;
	Tue, 23 Jan 2001 12:59:37 -0500
Message-ID: <3A6DC64A.82CA93AA@parsec.org>
Date: Tue, 23 Jan 2001 18:58:34 +0100
From: Markus Hadwiger <msh@parsec.org>
Organization: PARSEC.ORG
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jeff Hartmann <jhartmann@valinux.com>
CC: Michael Guntsche <m.guntsche@epitel.at>, linux-kernel@vger.kernel.org,
        dri-devel@lists.sourceforge.net
Subject: Re: [Dri-devel] Re: AGPGART problems with VIA KX133 chipsets under 
 2.2.18/2.4.0
In-Reply-To: <NDBBJOKGIPCDBEEFHNFPGECPCAAA.m.guntsche@epitel.at> <3A6DB677.2060109@valinux.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Michael Guntsche wrote:
> > While playing around with the agpgart module I noticed the following strange
> > behaviour.
> >
> > The hardware in question is an Asus K7V with the KX133 chipset and has been
> > tested on both 2.4.0 and 2.2.18 kernels.

Jeff Hartmann wrote:
> Can you try this patch and tell me if it fixes the problem (against 2.4.0)?

I tried it out on a VIA Apollo Pro 133A system (Pentium III)
and it seems to work. Previously, I had the same problem as Michael
and only got agpgart to work by temporarily hard-coding the correct
aperture base address in agpgart_be.c.

Thanks,
Markus
--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
