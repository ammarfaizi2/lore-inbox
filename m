Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131768AbRBDPFi>; Sun, 4 Feb 2001 10:05:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131789AbRBDPF2>; Sun, 4 Feb 2001 10:05:28 -0500
Received: from www.inreko.ee ([195.222.18.2]:33233 "EHLO www.inreko.ee")
	by vger.kernel.org with ESMTP id <S131768AbRBDPFO>;
	Sun, 4 Feb 2001 10:05:14 -0500
Date: Sun, 4 Feb 2001 17:15:37 +0200
From: Marko Kreen <marko@l-t.ee>
To: "Joachim 'roh' Steiger" <roh@convergence.de>
Cc: patrick.mourlhon@wanadoo.fr, linux-kernel@vger.kernel.org
Subject: Re: ATAPI CDRW which doesn't work
Message-ID: <20010204171537.A19909@l-t.ee>
In-Reply-To: <20010204030644.A23913@l-t.ee> <Pine.LNX.4.21.0102041112120.20715-100000@campari.convergence.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0102041112120.20715-100000@campari.convergence.de>; from roh@convergence.de on Sun, Feb 04, 2001 at 11:16:16AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 04, 2001 at 11:16:16AM +0100, Joachim 'roh' Steiger wrote:
> On Sun, 4 Feb 2001, Marko Kreen wrote:
> > Compile in options 'SCSI generic', 'SCSI cdrom and 'SCSI
> > emulation support' then add 'hdb=scsi' to kernel parameters.
> is there someone working on direct support for Atapi-cdrw this time?
> i would like to use a clean solution and am ready to help testing such
> stuff (if existing) with my yamaha atapi-cdrw connected to an asus a7v

I guess the kernel does not care, the problem is the user-space
utilities want to spek SCSI.  You could contact the developers
of cdwriter or cdrecord I guess.

-- 
marko

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
