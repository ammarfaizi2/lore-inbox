Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264962AbSKERKS>; Tue, 5 Nov 2002 12:10:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264965AbSKERKK>; Tue, 5 Nov 2002 12:10:10 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:43669 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S264951AbSKERKA>;
	Tue, 5 Nov 2002 12:10:00 -0500
Date: Tue, 5 Nov 2002 18:16:27 +0100
From: Jens Axboe <axboe@suse.de>
To: Dave Jones <davej@codemonkey.org.uk>, Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.5 vi .config ; make oldconfig not working
Message-ID: <20021105171627.GA1830@suse.de>
References: <20021105165024.GJ13587@suse.de> <3DC7FB11.10209@pobox.com> <20021105171303.GA20881@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021105171303.GA20881@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 05 2002, Dave Jones wrote:
> On Tue, Nov 05, 2002 at 12:08:33PM -0500, Jeff Garzik wrote:
> 
>  > >Can it really be that one cannot edit a config file and run make
>  > >oldconfig anymore? I'm used to editing an entry in .config and running
>  > >oldconfig to fix things up, now it just reenables the option. That's
>  > >clearly a major regression.
>  > > 
>  > It works fine for me :)
>  > I don't think I could survive without the tried and true "vi .config ; 
>  > make oldconfig" kernel configurator :)
> 
> Here it seems to work fine if I delete a line completely, but
> if I change
> CONFIG_FOO=y
> to
> #CONFIG_FOO=y

Yeah that works. It will ask me about CONFIG_FOO when I run make
oldconfig, though.

I still think it's a regression, and a very annoying one too.

-- 
Jens Axboe

