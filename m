Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129107AbRBLJDd>; Mon, 12 Feb 2001 04:03:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129212AbRBLJDX>; Mon, 12 Feb 2001 04:03:23 -0500
Received: from app79.hitnet.RWTH-Aachen.DE ([137.226.181.79]:8711 "EHLO
	anduin.gondor.com") by vger.kernel.org with ESMTP
	id <S129107AbRBLJDK>; Mon, 12 Feb 2001 04:03:10 -0500
Date: Mon, 12 Feb 2001 10:03:07 +0100
From: Jan Niehusmann <jan@gondor.com>
To: Guest section DW <dwguest@win.tue.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: /dev/rtc not working on ASUS A7V133
Message-ID: <20010212100307.A491@gondor.com>
In-Reply-To: <20010212012755.A656@gondor.com> <20010212021532.A28317@win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <20010212021532.A28317@win.tue.nl>; from dwguest@win.tue.nl on Mon, Feb 12, 2001 at 02:15:32AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 12, 2001 at 02:15:32AM +0100, Guest section DW wrote:
> I suppose you could give hwclock --directisa ?

I didn't try --directisa, but I did remove /dev/rtc, which, according
to hwclock's manpage should have the same effect.

Afterwards hwclock does work well. 

But I have a correction: The problem does not only occurr if the system
was started automatically by the bios, a manual 'soft off/soft on' sequence
shows the same effect. Only 'hard off/hard on' (using the switch directly 
on the power supply) seems to work every time.

Jan

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
