Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129842AbRAAXOU>; Mon, 1 Jan 2001 18:14:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129718AbRAAXOA>; Mon, 1 Jan 2001 18:14:00 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:1808 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129704AbRAAXNw>; Mon, 1 Jan 2001 18:13:52 -0500
Subject: Re: Chipsets, DVD-RAM, and timeouts....
To: stefan@hello-penguin.com
Date: Mon, 1 Jan 2001 22:44:05 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), axboe@suse.de (Jens Axboe),
        andre@linux-ide.org (Andre Hedrick),
        torvalds@transmeta.com (Linus Torvalds), linux-kernel@vger.kernel.org
In-Reply-To: <20010101231958.A1942@stefan.sime.com> from "Stefan Traby" at Jan 01, 2001 11:19:58 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14DDgV-0001R0-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> @@ -460,7 +460,7 @@
>  	opts.isvfat = sbi->options.isvfat;
>  	if (!parse_options((char *) data, &fat, &blksize, &debug, &opts, 
>  			   cvf_format, cvf_options)
> -	    || (blksize != 512 && blksize != 1024 && blksize != 2048))
> +	    || (blksize != 512 && blksize != 1024))
>  		goto out_fail;

This stops me using FAT on CD-ROM (which does work)

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
