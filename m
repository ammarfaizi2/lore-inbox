Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286613AbRLUWIx>; Fri, 21 Dec 2001 17:08:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286611AbRLUWIn>; Fri, 21 Dec 2001 17:08:43 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:30739 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S286612AbRLUWId>;
	Fri, 21 Dec 2001 17:08:33 -0500
Date: Fri, 21 Dec 2001 23:07:11 +0100
From: Jens Axboe <axboe@kernel.org>
To: Bob_Tracy <rct@gherkin.frus.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: sr: unaligned transfer
Message-ID: <20011221230711.E2929@suse.de>
In-Reply-To: <20011221142133.C811@suse.de> <m16HVwW-0005khC@gherkin.frus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m16HVwW-0005khC@gherkin.frus.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 21 2001, Bob_Tracy wrote:
> Jens Axboe wrote:
> > On Fri, Dec 21 2001, Bob_Tracy wrote:
> > > 	sr: unaligned transfer
> > > 	Unable to identify CD-ROM format.
> > 
> > What fs?
> 
> iso9660.
> 
> > Please try and mount with -o loop instead.
> 
> ???  Sorry if I'm being dense, but the file system is on a physical
> CD: it isn't an image file.  The mount command that has worked for me
> in the past is
> 
> 	mount -t iso9660 /dev/sr1 /mnt -r
> 
> The sr1 device isn't a typo: it's my cd writer.

mount -o loop -t iso9660 /dev/scd1 /mnt

-- 
Jens Axboe

