Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S144889AbRA2CD7>; Sun, 28 Jan 2001 21:03:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S137010AbRA2CDu>; Sun, 28 Jan 2001 21:03:50 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:62220 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S136918AbRA2CDb>;
	Sun, 28 Jan 2001 21:03:31 -0500
Date: Mon, 29 Jan 2001 03:02:52 +0100
From: Jens Axboe <axboe@suse.de>
To: Tony.Young@ir.com
Cc: slug@slug.org.au, csa@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: Linux Disk Performance/File IO per process
Message-ID: <20010129030252.I12772@suse.de>
In-Reply-To: <C0D2F5944500D411AD8A00104B31930E108096@ir_nt_server2>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C0D2F5944500D411AD8A00104B31930E108096@ir_nt_server2>; from Tony.Young@ir.com on Mon, Jan 29, 2001 at 12:54:00PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 29 2001, Tony.Young@ir.com wrote:
> All,
> 
> I work for a company that develops a systems and performance management
> product for Unix (as well as PC and TANDEM) called PROGNOSIS. Currently we
> support AIX, HP, Solaris, UnixWare, IRIX, and Linux.
> 
> I've hit a bit of a wall trying to expand the data provided by our Linux
> solution - I can't seem to find anywhere that provides the metrics needed to
> calculate disk busy in the kernel! This is a major piece of information that
> any mission critical system administrator needs to successfully monitor
> their systems.

The stock kernel doesn't provide either, but at least with Stephen's
sard patches you can get system wide I/O metrics.

ftp.linux.org.uk/pub/linux/sct/fs/profiling

-- 
Jens Axboe

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
