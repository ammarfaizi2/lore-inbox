Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129183AbQKMQ5F>; Mon, 13 Nov 2000 11:57:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129192AbQKMQ4q>; Mon, 13 Nov 2000 11:56:46 -0500
Received: from ferret.lmh.ox.ac.uk ([163.1.138.204]:48908 "HELO
	ferret.lmh.ox.ac.uk") by vger.kernel.org with SMTP
	id <S129183AbQKMQ4m>; Mon, 13 Nov 2000 11:56:42 -0500
Date: Mon, 13 Nov 2000 16:56:40 +0000 (GMT)
From: Chris Evans <chris@scary.beasts.org>
To: Torsten.Duwe@caldera.de
cc: Francis Galiegue <fg@mandrakesoft.com>, linux-kernel@vger.kernel.org
Subject: Re: Modprobe local root exploit
In-Reply-To: <14864.6812.849398.988598@ns.caldera.de>
Message-ID: <Pine.LNX.4.21.0011131655430.22139-100000@ferret.lmh.ox.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 13 Nov 2000, Torsten Duwe wrote:

> >>>>> "Francis" == Francis Galiegue <fg@mandrakesoft.com> writes:
> 
>     >> + if ((*p & 0xdf) >= 'a' && (*p & 0xdf) <= 'z') continue;
> 
>     Francis> Just in case... Some modules have uppercase letters too :)
> 
> That's what the &0xdf is intended for...

Code in a security sensitive area needs to be crystal clear.

What's wrong with isalnum() ?

Cheers
Chris

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
