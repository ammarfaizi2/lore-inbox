Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129444AbRAXVuZ>; Wed, 24 Jan 2001 16:50:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129445AbRAXVuP>; Wed, 24 Jan 2001 16:50:15 -0500
Received: from ezri.xs4all.nl ([194.109.253.9]:2245 "HELO ezri.xs4all.nl")
	by vger.kernel.org with SMTP id <S129444AbRAXVuK>;
	Wed, 24 Jan 2001 16:50:10 -0500
Date: Wed, 24 Jan 2001 22:50:07 +0100 (CET)
From: Eric Lammerts <eric@lammerts.org>
To: Brad Felmey <bradf@i-vic.net>
cc: Arkadiusz Miskiewicz <misiek@pld.ORG.PL>, <linux-kernel@vger.kernel.org>
Subject: Re: vfat <-> vfat copying of ~700MB file, so slow!
In-Reply-To: <997u6tsn18dp9u1h97q4j5jc9a2amn1nsp@i-vic.net>
Message-ID: <Pine.LNX.4.32.0101242249220.27055-100000@ally.lammerts.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 24 Jan 2001, Brad Felmey wrote:
> > I/O support  =  0 (default 16-bit)
>
> hdparm -c1 /dev/hda, or are you running in 16-bit mode on purpose?

The -c option is only relevant for PIO modes. In this case DMA was on,
so it doesn't make any difference.

Eric

-- 
Eric Lammerts <eric@lammerts.org> | The best way to accelerate a computer
http://www.lammerts.org           | running Windows is at 9.8 m/s^2.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
