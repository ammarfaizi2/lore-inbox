Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262275AbUKQK4t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262275AbUKQK4t (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 05:56:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262272AbUKQK4t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 05:56:49 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:62145 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262261AbUKQKwT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 05:52:19 -0500
Date: Wed, 17 Nov 2004 04:47:27 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Atro.Tossavainen@helsinki.fi
Cc: linux-kernel@vger.kernel.org, mikem@beardog.cca.cpqcorp.net
Subject: Re: 2.4.27 and CCISS related problem
Message-ID: <20041117064727.GD19107@logos.cnet>
References: <200411170930.iAH9UNMf004077@kruuna.Helsinki.FI>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200411170930.iAH9UNMf004077@kruuna.Helsinki.FI>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,


On Wed, Nov 17, 2004 at 11:30:23AM +0200, Atro Tossavainen wrote:
> Hello all,
> 
> Got a problem with a HP Proliant DL380 with root on a RAID1 behind a
> Smart Array 5i+.  It boots up fine with 2.4.25, but halts every time
> with 2.4.27.  The following message should be printed:
> 
> 	HP CISS Driver (v 2.4.50)
> 	cciss: Device 0xb178 has been found at bus 1 dev 3 func 0
> 	      blocks= 71122560 block_size= 512
> 	      heads= 255, sectors= 32, cylinders= 8716 RAID 1(0+1)
> 	
> 	blk: queue c04c6c40, I/O limit 4294967295Mb (mask 0xffffffffffffffff)
> 	Partition check:
> 	 cciss/c0d0: p1 p2 < p5 p6 p7 p8 >
> 
> But instead, it prints:
> 
> 	blk: queue c04c6c40, I/O limit 4294967295Mb (mask 0xffffffffffffffff)
> 	Partition check:
> 	 cciss/c0d0:
> 
> and freezes there, but not so badly that Ctl-Alt-Del wouldn't let me
> reboot.  Anybody got any ideas?  The kernels I am using are based on
> Linus' from ftp.funet.fi, with i2c, lm_sensors and MOSIX added in.
> I can try with a completely vanilla 2.4.27 if necessary.

Please try vanilla v2.4.27.

If that doesnt work, go down to v2.4.26.

Both of them contain cciss updates.
