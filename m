Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279462AbRKASQb>; Thu, 1 Nov 2001 13:16:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279464AbRKASQW>; Thu, 1 Nov 2001 13:16:22 -0500
Received: from 89.ppp1-5.hob.worldonline.dk ([212.54.87.89]:52097 "EHLO
	milhouse.home.kernel.dk") by vger.kernel.org with ESMTP
	id <S279462AbRKASQO>; Thu, 1 Nov 2001 13:16:14 -0500
Date: Thu, 1 Nov 2001 19:15:22 +0100
From: Jens Axboe <axboe@suse.de>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        linux-kernel@vger.kernel.org
Subject: Re: Stress testing 2.4.14-pre6
Message-ID: <20011101191521.H3265@suse.de>
In-Reply-To: <Pine.LNX.4.33.0111010903280.11617-100000@penguin.transmeta.com> <3BE18402.9F958EDC@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3BE18402.9F958EDC@mandrakesoft.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 01 2001, Jeff Garzik wrote:
> Linus Torvalds wrote:
> > Anyway, I seriously doubt this explains any real-world bad behaviour: the
> > window for the interrupt hitting a half-way updated list is something like
> > two instructions long out of the whole memory freeing path. AND most
> > interrupts don't actually do any allocation.
> 
> Network Rx interrupts do....  definitely not as frequent as IDE
> interrupts, but not infrequent.

Which IDE interrupts allocate memory?!

-- 
Jens Axboe

