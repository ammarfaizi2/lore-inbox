Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261340AbSIWTTf>; Mon, 23 Sep 2002 15:19:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261344AbSIWTSW>; Mon, 23 Sep 2002 15:18:22 -0400
Received: from air-2.osdl.org ([65.172.181.6]:14353 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S261340AbSIWTSE>;
	Mon, 23 Sep 2002 15:18:04 -0400
Date: Mon, 23 Sep 2002 12:23:15 -0700
From: Dave Olien <dmo@osdl.org>
To: axboe@suse.de
Cc: linux-kernel@vger.kernel.org, phillips@arcor.de, _deepfire@mail.ru
Subject: Re: [2.5] DAC960
Message-ID: <20020923122315.A15541@acpi.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, Sep 20 2002, Jens Axboe wrote:
> 
> Neither 2.5.35 nor 2.5.36 has any critical bio fixes, so I would look
> into this a bit more if I were you. Only if you were using
> bio_kmap_irq() would there be something to look for, but DAC960 is not.
> That was 2.5.35. 2.5.36 just starts sizing bio_vec pools based on free
> memory, no bug fixes. Likewise in the block layer, I'm not seeing
> anything.

I'll spend some time this week looking into this.  I have an idea
on how I might track down what's going on.  I'll let you know if
I discover anything.

Thanks!

Dave
