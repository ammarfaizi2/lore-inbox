Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267089AbSKMBed>; Tue, 12 Nov 2002 20:34:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267090AbSKMBed>; Tue, 12 Nov 2002 20:34:33 -0500
Received: from mail3.noris.net ([62.128.1.28]:48778 "EHLO mail3.noris.net")
	by vger.kernel.org with ESMTP id <S267089AbSKMBec>;
	Tue, 12 Nov 2002 20:34:32 -0500
From: "Matthias Urlichs" <smurf@noris.de>
Date: Wed, 13 Nov 2002 02:41:18 +0100
To: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: PATCH 2.4: scsi and BLK_STATS
Message-ID: <20021113024118.M18881@noris.de>
References: <20021112172821.GA14195@play.smurf.noris.de> <20021113001530.A323@infradead.org> <20021113023059.K18881@noris.de> <20021113013717.A3008@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021113013717.A3008@infradead.org>; from hch@infradead.org on Wed, Nov 13, 2002 at 01:37:17AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Christoph Hellwig:
> > anyway, please disregard my patch and add
> > 
> > #include <linux/genhd.h>
> > 
> > in scsi/scsi_lib.c.  :-/
> 
> It already gets genhd.h through blk.h -> blkdev.h.. :)

... then why did I get that undefined symbol in scsi_mod.o, I wonder ??

-- 
Matthias Urlichs     |     noris network AG     |     http://smurf.noris.de/
