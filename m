Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129370AbQLaNtt>; Sun, 31 Dec 2000 08:49:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129450AbQLaNtk>; Sun, 31 Dec 2000 08:49:40 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:14856 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S129370AbQLaNtW>;
	Sun, 31 Dec 2000 08:49:22 -0500
Date: Sun, 31 Dec 2000 14:18:55 +0100
From: Jens Axboe <axboe@suse.de>
To: Raphael Manfredi <Raphael_Manfredi@pobox.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.0 test13-pre7 still causes CDROM ioctl errors
Message-ID: <20001231141855.B574@suse.de>
In-Reply-To: <1344.978265187@nice.ram.loc>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1344.978265187@nice.ram.loc>; from Raphael_Manfredi@pobox.com on Sun, Dec 31, 2000 at 01:19:47PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 31 2000, Raphael Manfredi wrote:
> I had sent the following report a week ago:
> 
> --------------------------
> Since I've installed 2.4.0 test13-pre4, I see the following errors
> in my log:
> 
> 	sr0: CDROM (ioctl) reports ILLEGAL REQUEST.
> 
> and xmcd reports:
> 
> 	CD audio: ioctl error on /dev/scd0: cmd=CDROMVOLCTRL errno=95
> 
> This was working fine with 2.4.0 test12-pre5, which was the previous
> kernel I was using.
> -------------------------
> 
> Well, I installed 2.4.0 test13-pre7 and I still have the same error.

Appears audio capabilities are not being detected as supported. What
does /proc/sys/dev/cdrom/info say? And what does the sr_mod load line
look like?

-- 
* Jens Axboe <axboe@suse.de>
* SuSE Labs
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
