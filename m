Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263080AbRFGU3c>; Thu, 7 Jun 2001 16:29:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263088AbRFGU3W>; Thu, 7 Jun 2001 16:29:22 -0400
Received: from age.cs.columbia.edu ([128.59.22.100]:24847 "EHLO
	age.cs.columbia.edu") by vger.kernel.org with ESMTP
	id <S263080AbRFGU3L>; Thu, 7 Jun 2001 16:29:11 -0400
Date: Thu, 7 Jun 2001 13:29:07 -0700 (PDT)
From: Ion Badulescu <ionut@cs.columbia.edu>
To: Tom Sightler <ttsig@tuxyturvy.com>
cc: <linux-kernel@vger.kernel.org>, <arjan@fenrus.demon.nl>
Subject: Re: xircom_cb problems
In-Reply-To: <991939245.3b1fcaada710e@eargle.com>
Message-ID: <Pine.LNX.4.33.0106071322160.22593-100000@age.cs.columbia.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Jun 2001, Tom Sightler wrote:

> Transferring files between the eepro100 machine running 2.4.2-ac11 and my 
> laptop produced a result of 2.24MB/s for sending and 2.13MB/s recieving the 
> file.
> 
> Transfering files between the Alteon Gigabit machine running 2.2.19 and my 
> laptop resulted in the dismal numbers of 249KB/s sending and 185KB/s recieving, 
> close to the numbers you quoted above, but actually slightly worse.
> 
> I'm not sure what would explain the 2.2.19 1GB conencted box being 10x slower 
> than the 2.4.2-ac11 100MB machine.

Both of these are slow, actually. I'm getting 7.5-8MB/s when receiving 
from a 100Mbit box (tulip or starfire, doesn't seem to matter). 
Transmitting is still slow for me, but that is most likely a different 
problem -- and I'm looking into it.

Moreover, I'm getting 9+MB/s in both directions when using the other 
driver (xircom_tulip_cb), patched to do half-duplex only. So the card can 
definitely transfer at network speeds.

> I'll apply your patch with the change to MII handling and rerun some simple 
> file transfers and report the results soon.

Looking forward to seeing them...

Thanks,
Ion

-- 
  It is better to keep your mouth shut and be thought a fool,
            than to open it and remove all doubt.

