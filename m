Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129094AbRAaVeG>; Wed, 31 Jan 2001 16:34:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129095AbRAaVd4>; Wed, 31 Jan 2001 16:33:56 -0500
Received: from anime.net ([63.172.78.150]:776 "EHLO anime.net")
	by vger.kernel.org with ESMTP id <S129094AbRAaVdn>;
	Wed, 31 Jan 2001 16:33:43 -0500
Date: Wed, 31 Jan 2001 13:33:30 -0800 (PST)
From: Dan Hollis <goemon@anime.net>
To: James Sutherland <jas88@cam.ac.uk>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, James Simmons <jsimmons@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: CPU error codes
In-Reply-To: <Pine.SOL.4.21.0101312122380.1537-100000@orange.csi.cam.ac.uk>
Message-ID: <Pine.LNX.4.30.0101311332410.23610-100000@anime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Jan 2001, James Sutherland wrote:
> On Wed, 31 Jan 2001, Alan Cox wrote:
> > Parity/ECC on main memory is reported by the chipset and needs seperate
> > drivers or apps to handle this
> Yes - MCE only covers errors in the CPU's cache, IIRC? (Is there still an
> NMI on main memory parity errors, or has this changed on modern
> chipsets? Presumably ECC is handled differently, being recoverable??)

You can program the northbridge to generate NMI or not, on ECC errors.
Most chipsets still need to scrub memory after an error to reset ECC bits.

-Dan

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
