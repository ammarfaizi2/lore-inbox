Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261364AbSJYKdg>; Fri, 25 Oct 2002 06:33:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261365AbSJYKdg>; Fri, 25 Oct 2002 06:33:36 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:45257 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S261364AbSJYKdg>;
	Fri, 25 Oct 2002 06:33:36 -0400
Date: Fri, 25 Oct 2002 12:39:38 +0200
From: Jens Axboe <axboe@suse.de>
To: Nyk Tarr <nyk@giantx.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Bug] 2.5.44-ac2 cdrom eject panic
Message-ID: <20021025103938.GN4153@suse.de>
References: <20021025103631.GA588@giantx.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021025103631.GA588@giantx.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 25 2002, Nyk Tarr wrote:
> 
> Hi,
> 
> I got this nice error after doing an 'eject /cdrom'

[snip]

2.5.44 and thus 2.5.44-acX has seriously broken REQ_BLOCK_PC, so it's no
wonder that it breaks hard. Alan, I can sync the sgio patches for you if
you want.

Nyk, if you could try

*.kernel.org/pub/linux/kernel/people/axboe/patches/v2.5/2.5.44/sgio-15.bz2

that would be great, thanks.

-- 
Jens Axboe

