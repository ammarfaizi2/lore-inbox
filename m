Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130144AbQLJXxW>; Sun, 10 Dec 2000 18:53:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130657AbQLJXxN>; Sun, 10 Dec 2000 18:53:13 -0500
Received: from Cantor.suse.de ([194.112.123.193]:40465 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S130144AbQLJXxA>;
	Sun, 10 Dec 2000 18:53:00 -0500
Date: Mon, 11 Dec 2000 00:22:39 +0100
From: Jens Axboe <axboe@suse.de>
To: clock@atrey.karlin.mff.cuni.cz
Cc: linux-kernel@vger.kernel.org
Subject: Re: Dropping chars on 16550
Message-ID: <20001211002239.N294@suse.de>
In-Reply-To: <20001210211445.00733@ghost.btnet.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20001210211445.00733@ghost.btnet.cz>; from clock@ghost.btnet.cz on Sun, Dec 10, 2000 at 09:14:45PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 10 2000, clock@ghost.btnet.cz wrote:
> Hi folks
> 
> What should I do, when I run cdda2wav | gogo (riping CD from a ATAPI
> CD thru mp3 encoder) and get a continuous dropping of characters, on a 16550-
> enhanced serial port, without handshake, with full-duplex load of 115200 bps?
> About 1 of 320 bytes is miscommunicated.
> 
> The kernel is 2.2.12.

hdparm -u1 /dev/hdX

-- 
* Jens Axboe <axboe@suse.de>
* SuSE Labs
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
