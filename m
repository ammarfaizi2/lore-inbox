Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131375AbQLLMLa>; Tue, 12 Dec 2000 07:11:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131684AbQLLMLU>; Tue, 12 Dec 2000 07:11:20 -0500
Received: from Cantor.suse.de ([194.112.123.193]:57874 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S131375AbQLLMLJ>;
	Tue, 12 Dec 2000 07:11:09 -0500
Date: Tue, 12 Dec 2000 12:40:09 +0100
From: Jens Axboe <axboe@suse.de>
To: Xavier Bestel <xavier.bestel@free.fr>
Cc: Jonathan Morton <chromatix@penguinpowered.com>,
        linux-kernel@vger.kernel.org
Subject: Re: 2.2.18pre24 spurious diskchanges
Message-ID: <20001212124009.P294@suse.de>
In-Reply-To: <l03130303b65ba02ad4e6@[192.168.239.101]> <200012121023.LAA05097@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200012121023.LAA05097@microsoft.com>; from xavier.bestel@free.fr on Tue, Dec 12, 2000 at 09:23:35AM -0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 12 2000, Xavier Bestel wrote:
> > >on my ide CDROm I get, roughly each 2 seconds, disk changes although the
> > >drive is empty and I don't touch it:
> > >
> > >Dec 12 08:57:43 localhost kernel: VFS: Disk change detected on device
> > >ide0(3,64)
> > >Dec 12 08:58:14 localhost last message repeated 16 times
> > >Dec 12 08:59:16 localhost last message repeated 31 times
> > >Dec 12 09:00:17 localhost last message repeated 30 times
> > >Dec 12 09:01:19 localhost last message repeated 31 times
> > >Dec 12 09:02:21 localhost last message repeated 31 times
> > >etc ...
> > 
> > It would probably help if you told us what make/model CD-ROM drive, and
> > whether you're using any particular driver with it (usually the standard
> > ATAPI one).

Huh? It says (3,64) which would make it hdd -- the only driver possible
is ide-cd here.

> Oops, I just killed magicdev, as told by someone, and this is gone.

Yep, remove that awful beast.

-- 
* Jens Axboe <axboe@suse.de>
* SuSE Labs
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
