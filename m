Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317278AbSFGMMy>; Fri, 7 Jun 2002 08:12:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317279AbSFGMMx>; Fri, 7 Jun 2002 08:12:53 -0400
Received: from inet-mail4.oracle.com ([148.87.2.204]:45775 "EHLO
	inet-mail4.oracle.com") by vger.kernel.org with ESMTP
	id <S317278AbSFGMMv>; Fri, 7 Jun 2002 08:12:51 -0400
Message-ID: <3D00A231.3020003@oracle.com>
Date: Fri, 07 Jun 2002 14:08:17 +0200
From: Alessandro Suardi <alessandro.suardi@oracle.com>
Organization: Oracle Support Services
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020516
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Patrick Mochel <mochel@osdl.org>
CC: Jeff Garzik <jgarzik@mandrakesoft.com>,
        Mikael Pettersson <mikpe@csd.uu.se>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.20 tulip bogosities
In-Reply-To: <Pine.LNX.4.33.0206061139111.654-100000@geena.pdx.osdl.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patrick Mochel wrote:
> On Thu, 6 Jun 2002, Jeff Garzik wrote:
> 
> 
>>Mikael,
>>
>>Can you try an experiment for me?
>>
>>Run 2.5.19 with the 2.5.20 tulip.  Just copy drivers/net/tulip/* from 
>>2.5.20 into 2.5.19.
>>
>>Nothing changed in 2.5.20 tulip that should cause that, AFAICS.  So I 
>>want to narrow down the problem before looking further.
> 
> 
> There was a bug in the PCI code that only passed the first device ID the 
> driver supported to the driver's probe callback. It caused a few other 
> oddities. A patch was posted to the list:
> 
> http://marc.theaimsgroup.com/?l=linux-kernel&m=102316813812289&w=2
> 
> and is now in Linus' tree. It should fix the problem, if you get a chance 
> to test it...

Just wanted to restate that this patch is still not enough to
  make my Xircom PCI CardBus card work properly (xircom_cb driver).

Jun  7 12:49:24 dolphin cardmgr[597]: get dev info on socket 0 failed: Resource temporarily unavailable

All LEDs on the card never light up at all.

--alessandro

  "the hands that build / can also pull down
    even the hands of love"
                             (U2, "Exit")

