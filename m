Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261440AbSJYOg3>; Fri, 25 Oct 2002 10:36:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261442AbSJYOg3>; Fri, 25 Oct 2002 10:36:29 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:64397 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S261440AbSJYOg2>;
	Fri, 25 Oct 2002 10:36:28 -0400
Date: Fri, 25 Oct 2002 16:42:24 +0200
From: Jens Axboe <axboe@suse.de>
To: Markus Plail <plail@web.de>
Cc: linux-kernel@vger.kernel.org, Vegard.Lima@hia.no,
       matthias.welk@fokus.gmd.de
Subject: Re: [Bug] 2.5.44-ac2 cdrom eject panic
Message-ID: <20021025144224.GW4153@suse.de>
References: <20021025103631.GA588@giantx.co.uk> <20021025103938.GN4153@suse.de> <87adl2is1u.fsf@gitteundmarkus.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87adl2is1u.fsf@gitteundmarkus.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 25 2002, Markus Plail wrote:
> Hi Jens!
> 
> * Jens Axboe writes:
> >2.5.44 and thus 2.5.44-acX has seriously broken REQ_BLOCK_PC, so it's
> >no wonder that it breaks hard. Alan, I can sync the sgio patches for
> >you if you want.
> 
> >Nyk, if you could try
> >*.kernel.org/pub/linux/kernel/people/axboe/patches/v2.5/2.5.44/sgio-15.bz2
> >that would be great, thanks.
> 
> Is this the patch Jörg Schilling was testing to get DMA with the new
> dev=/dev/hd* interface working? I just did some tests. Audio CD ripping
> worked just fine. When I try to burn a CD I get a kernel panic. Are you
> intersted in further results?

Please try:

*.kernel.org/pub/linux/kernel/people/axboe/patches/v2.5/2.5.44/sgio-16.bz2

That should fix the silly panic.

-- 
Jens Axboe

