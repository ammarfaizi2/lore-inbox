Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261429AbSJYO3L>; Fri, 25 Oct 2002 10:29:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261432AbSJYO3L>; Fri, 25 Oct 2002 10:29:11 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:15245 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S261429AbSJYO3L>;
	Fri, 25 Oct 2002 10:29:11 -0400
Date: Fri, 25 Oct 2002 16:35:06 +0200
From: Jens Axboe <axboe@suse.de>
To: Markus Plail <plail@web.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Bug] 2.5.44-ac2 cdrom eject panic
Message-ID: <20021025143506.GV4153@suse.de>
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

Yes, Joerg and others have been testing it with good results. sgio-15
seemed to be a bad version though, I'll put up sgio-16 later today. If
you could test that, I would much appreciate it.

-- 
Jens Axboe

