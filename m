Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129982AbRAWUit>; Tue, 23 Jan 2001 15:38:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130391AbRAWUia>; Tue, 23 Jan 2001 15:38:30 -0500
Received: from cmn2.cmn.net ([206.168.145.10]:53320 "EHLO cmn2.cmn.net")
	by vger.kernel.org with ESMTP id <S129982AbRAWUiZ>;
	Tue, 23 Jan 2001 15:38:25 -0500
Message-ID: <3A6DEAF2.9090108@valinux.com>
Date: Tue, 23 Jan 2001 13:34:58 -0700
From: Jeff Hartmann <jhartmann@valinux.com>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.12-20smp i686; en-US; m18) Gecko/20001107 Netscape6/6.0
X-Accept-Language: en
MIME-Version: 1.0
To: Markus Hadwiger <msh@parsec.org>
CC: Michael Guntsche <m.guntsche@epitel.at>, linux-kernel@vger.kernel.org,
        dri-devel@lists.sourceforge.net
Subject: Re: [Dri-devel] Re: AGPGART problems with VIA KX133 chipsets under 
	 2.2.18/2.4.0
In-Reply-To: <NDBBJOKGIPCDBEEFHNFPGECPCAAA.m.guntsche@epitel.at> <3A6DB677.2060109@valinux.com> <3A6DC64A.82CA93AA@parsec.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Markus Hadwiger wrote:

> Michael Guntsche wrote:
> 
>>> While playing around with the agpgart module I noticed the following strange
>>> behaviour.
>>> 
>>> The hardware in question is an Asus K7V with the KX133 chipset and has been
>>> tested on both 2.4.0 and 2.2.18 kernels.
>> 
> 
> Jeff Hartmann wrote:
> 
>> Can you try this patch and tell me if it fixes the problem (against 2.4.0)?
> 
> 
> I tried it out on a VIA Apollo Pro 133A system (Pentium III)
> and it seems to work. Previously, I had the same problem as Michael
> and only got agpgart to work by temporarily hard-coding the correct
> aperture base address in agpgart_be.c.
> 
> Thanks,
> Markus
> --
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/

All the VIA chipsets are pretty much the same so this should fix the 
problem on everyone's system.  I'll send a proper patch to Linus later 
today.

-Jeff

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
