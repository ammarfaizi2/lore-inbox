Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269926AbRHWSQd>; Thu, 23 Aug 2001 14:16:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269868AbRHWSQX>; Thu, 23 Aug 2001 14:16:23 -0400
Received: from [209.202.108.240] ([209.202.108.240]:15888 "EHLO
	terbidium.openservices.net") by vger.kernel.org with ESMTP
	id <S269718AbRHWSQF>; Thu, 23 Aug 2001 14:16:05 -0400
Date: Thu, 23 Aug 2001 14:16:06 -0400 (EDT)
From: Ignacio Vazquez-Abrams <ignacio@openservices.net>
To: "MEHTA,HIREN (A-SanJose,ex1)" <hiren_mehta@agilent.com>
cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "'linux-scsi@vger.kernel.org'" <linux-scsi@vger.kernel.org>
Subject: Re: releasing driver to kernel in source+binary format
In-Reply-To: <FEEBE78C8360D411ACFD00D0B7477971880B3E@xsj02.sjs.agilent.com>
Message-ID: <Pine.LNX.4.33.0108231414000.14247-100000@terbidium.openservices.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-scanner: scanned by Inflex 1.0.7 - (http://pldaniels.com/inflex/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Aug 2001, MEHTA,HIREN (A-SanJose,ex1) wrote:

> Hi list,
>
> We want to release a linux scsi hba-driver for our fibre-channel
> HBAs and make it part of the kernel source tree. Because of IP
> related issues, we can only release one part of the sources with
> GPL. We want to release the other part in the binary format (.o)
> as a library which needs to be linked with the first part.
> If somebody can advise me on how to go about this, I would
> appreciate it.
>
> I went through the "SubmittingDrivers" file
> which does not talk about this kind of special cases.
>
> Regards,
> -hiren
> Agilent Technologies.

It's probably just easier to supply a non-GPLed binary-only driver. Realize,
though, that if you have any sort of binary-only driver in any way, there are
those who will a) refuse to buy or use your product(s), and b) persuade others
to do the same.

-- 
Ignacio Vazquez-Abrams  <ignacio@openservices.net>

