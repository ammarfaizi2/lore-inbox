Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130633AbRAaVZg>; Wed, 31 Jan 2001 16:25:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131481AbRAaVZ0>; Wed, 31 Jan 2001 16:25:26 -0500
Received: from orange.csi.cam.ac.uk ([131.111.8.77]:34492 "EHLO
	orange.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S130633AbRAaVZO>; Wed, 31 Jan 2001 16:25:14 -0500
Date: Wed, 31 Jan 2001 21:24:51 +0000 (GMT)
From: James Sutherland <jas88@cam.ac.uk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: James Simmons <jsimmons@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: CPU error codes
In-Reply-To: <E14Nz6N-0002Vj-00@the-village.bc.nu>
Message-ID: <Pine.SOL.4.21.0101312122380.1537-100000@orange.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Jan 2001, Alan Cox wrote:

> > > In the intel databook. Generally an MCE indicates hardware/power/cooling
> > > issues
> > 
> > Doesn't an MCE also cover some hardware memory problems - parity/ECC
> > issues etc?
> 
> Parity/ECC on main memory is reported by the chipset and needs seperate
> drivers or apps to handle this

Yes - MCE only covers errors in the CPU's cache, IIRC? (Is there still an
NMI on main memory parity errors, or has this changed on modern
chipsets? Presumably ECC is handled differently, being recoverable??)


James.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
