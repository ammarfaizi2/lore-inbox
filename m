Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315012AbSDWCHA>; Mon, 22 Apr 2002 22:07:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315013AbSDWCG7>; Mon, 22 Apr 2002 22:06:59 -0400
Received: from panic.tn.gatech.edu ([130.207.137.62]:13023 "HELO gtf.org")
	by vger.kernel.org with SMTP id <S315012AbSDWCG6>;
	Mon, 22 Apr 2002 22:06:58 -0400
Date: Mon, 22 Apr 2002 22:06:58 -0400
From: Jeff Garzik <garzik@havoc.gtf.org>
To: Richard Toilet <mojomofo@mojomofo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.5.5 to 2.5.7+] Something broke my squid cache
Message-ID: <20020422220658.A29096@havoc.gtf.org>
In-Reply-To: <051a01c1ea6a$915711c0$0800a8c0@atlink30g>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 22, 2002 at 09:59:56PM -0400, Richard Toilet wrote:
> 
> Going from 2.5.5 to 2.5.7 makes my squid cache serve out runt packets to any
> client that is on my intra-net but not external sources (eth0 in/out is
> fine, eth0 in/eth1 out is broken)..
> 
> This is definitely kernel related because I can downgrade from 2.5.7 to
> 2.5.5 and everything works as expected. I upgraded/downgraded squid versions
> and it didn't make any difference so I'm wondering if something netfilter
> related has changed. Both nics are Intel eepro100's, and it occurs using the
> intel and the modified becker driver.
> 
> Shoo.. little by little I'm working my way back to the kernel that breaks it
> but if anyone else has run into this, maybe they have some insight and can
> save me some work. :)

For drivers at least, you can probably copy your key drivers from 2.5.7
into 2.5.5, and see what breaks...  If that eliminates the drivers, or
signals a problematic driver, this may save you some time.

	Jeff



