Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271750AbRH0OiB>; Mon, 27 Aug 2001 10:38:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271747AbRH0Ohl>; Mon, 27 Aug 2001 10:37:41 -0400
Received: from age.cs.columbia.edu ([128.59.22.100]:55822 "EHLO
	age.cs.columbia.edu") by vger.kernel.org with ESMTP
	id <S271744AbRH0Oha>; Mon, 27 Aug 2001 10:37:30 -0400
Date: Mon, 27 Aug 2001 10:37:30 -0400 (EDT)
From: Ion Badulescu <ionut@cs.columbia.edu>
To: safemode <safemode@speakeasy.net>
cc: Mikael Pettersson <mikpe@csd.uu.se>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH,RFC] make ide-scsi more selective
In-Reply-To: <200108251734.NAA28426@cs.columbia.edu>
Message-ID: <Pine.LNX.4.33.0108271033280.1461-100000@age.cs.columbia.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Aug 2001, safemode wrote:

> Is there something wrong with making the Atapi cdrom driver as module and 
> then loading that with an ignore hdX then loading the ide-scsi module?  That 
> doesn't seem hard at all.  just two pretty lines in /etc/modules.  Just make 
> both drivers modular.   otherwise you have people needing to do boot 
> arguments through lilo.  

Some people actually _like_ having a non-modular kernel and passing 
arguments through lilo. As for myself, personally I just like having both 
equally functional so I can choose whichever is better for the task at 
hand.

> and andre had a patch at one time that was supposed to do something like 
> allow you to use the recording function of ide CDR's without the scsi layer.  
> Not sure if it was complete or even really working but i tried it once.  
> Maybe you can ask him if it's possible.  

The packet writing stuff? That's actually Jens Axboe's work, and is very 
different from the good ol' CD burning technique.

Ion

-- 
  It is better to keep your mouth shut and be thought a fool,
            than to open it and remove all doubt.

