Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261654AbSI0Hj7>; Fri, 27 Sep 2002 03:39:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261652AbSI0Hj7>; Fri, 27 Sep 2002 03:39:59 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:36483 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S261438AbSI0Hj5>;
	Fri, 27 Sep 2002 03:39:57 -0400
Date: Fri, 27 Sep 2002 09:45:09 +0200
From: Jens Axboe <axboe@suse.de>
To: Matthew Jacob <mjacob@feral.com>
Cc: "Justin T. Gibbs" <gibbs@scsiguy.com>,
       "Pedro M. Rodrigues" <pmanuel@myrealbox.com>,
       Mathieu Chouquet-Stringer <mathieu@newview.com>,
       linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Warning - running *really* short on DMA buffers while doing file transfers
Message-ID: <20020927074509.GA860@suse.de>
References: <Pine.BSF.4.21.0209270029280.18144-100000@beppo> <Pine.BSF.4.21.0209270031360.18144-100000@beppo>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.BSF.4.21.0209270031360.18144-100000@beppo>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 27 2002, Matthew Jacob wrote:
> 
> The issue here is not whether it's appropriate to oversaturate the
> 'standard' SCSI drive- it isn't- I never suggested it was.

Ok so we agree. I think our oversaturate thresholds are different,
though.

> I'd just suggest that it's asinine to criticise an HBA for running up to
> reasonable limits when it's the non-toy OS that will do sensible I/O
> scheduling. So point your gums elsewhere.

Well I don't think 253 is a reasonable limit, that was the whole point.
How can sane io scheduling ever prevent starvation in that case? I can't
point my gums elsewhere, this is where I'm seeing starvation.

-- 
Jens Axboe

