Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317472AbSF1R7z>; Fri, 28 Jun 2002 13:59:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317473AbSF1R7y>; Fri, 28 Jun 2002 13:59:54 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:54479 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S317472AbSF1R7y>;
	Fri, 28 Jun 2002 13:59:54 -0400
Date: Fri, 28 Jun 2002 20:02:03 +0200
From: Jens Axboe <axboe@suse.de>
To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Status of write barrier support for 2.4?
Message-ID: <20020628200203.A777@suse.de>
References: <20020627104534.GA31084@merlin.emma.line.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020627104534.GA31084@merlin.emma.line.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 27 2002, Matthias Andree wrote:
> Hi,
> 
> what is the status of write barrier support in Linux?

We have stable support for IDE (ie block layer barrier support works,
IDE implementation works). I doubt we'll ever do 2.4 SCSI support,
it would be too invasive to really make it safe.

> Is there a web page that documents patches and status?

Not to my knowledge.

-- 
Jens Axboe

