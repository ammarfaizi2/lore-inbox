Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290396AbSAPJai>; Wed, 16 Jan 2002 04:30:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290393AbSAPJa2>; Wed, 16 Jan 2002 04:30:28 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:48644 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S290395AbSAPJaN>;
	Wed, 16 Jan 2002 04:30:13 -0500
Date: Wed, 16 Jan 2002 10:29:36 +0100
From: Jens Axboe <axboe@suse.de>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Craig Christophel <merlin@transgeek.com>, linux-kernel@vger.kernel.org
Subject: Re: likely/unlikely
Message-ID: <20020116102936.K3805@suse.de>
In-Reply-To: <20020116032300.AAA27749@shell.webmaster.com@whenever> <3C450C4A.8A8382A6@mandrakesoft.com> <20020116113143.C99F8B581@smtp.transgeek.com> <3C454491.CA18D4AE@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C454491.CA18D4AE@mandrakesoft.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 16 2002, Jeff Garzik wrote:
> Craig Christophel wrote:
> > 
> > > likely/unlikely set the branch prediction values to 99% or 1%
> > 
> >         So all of the BUG() routines in the kernel would benifit greatly from this.
> 
> 
> It's likely :)  I would put one unlikely() in the definition of BUG_ON,
> rather rather touching all the code that calls BUG(), though.

BUG_ON has had unlikely since the very beginning :-)

-- 
Jens Axboe

