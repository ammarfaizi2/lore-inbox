Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264673AbSJOSQi>; Tue, 15 Oct 2002 14:16:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263256AbSJOSQf>; Tue, 15 Oct 2002 14:16:35 -0400
Received: from h68-147-110-38.cg.shawcable.net ([68.147.110.38]:58620 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S262828AbSJOSQD>; Tue, 15 Oct 2002 14:16:03 -0400
From: Andreas Dilger <adilger@clusterfs.com>
Date: Tue, 15 Oct 2002 12:19:28 -0600
To: Joe Thornber <joe@fib011235813.fsnet.co.uk>
Cc: Linux Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>, Dave Jones <davej@suse.de>
Subject: Re: [PATCH] Device-mapper submission 4/7
Message-ID: <20021015181928.GH15552@clusterfs.com>
Mail-Followup-To: Joe Thornber <joe@fib011235813.fsnet.co.uk>,
	Linux Mailing List <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@transmeta.com>, Dave Jones <davej@suse.de>
References: <20021015174624.GD27753@fib011235813.fsnet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021015174624.GD27753@fib011235813.fsnet.co.uk>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 15, 2002  18:46 +0100, Joe Thornber wrote:
> [Device-mapper]
> The linear target maps a contigous range of logical sectors onto an
> range of physical sectors.
> 
> +struct linear_c {
> +	long delta;		/* FIXME: we need a signed offset type */
> +	long start;		/* For display only */
> +	struct dm_dev *dev;
> +};

Should those not be sector_t type fields?

Cheers, Andreas
--
Andreas Dilger
http://www-mddsp.enel.ucalgary.ca/People/adilger/
http://sourceforge.net/projects/ext2resize/

