Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313504AbSDYWV1>; Thu, 25 Apr 2002 18:21:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313505AbSDYWV0>; Thu, 25 Apr 2002 18:21:26 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:51935 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S313504AbSDYWVZ>;
	Thu, 25 Apr 2002 18:21:25 -0400
Message-ID: <3CC88074.D6F112E6@vnet.ibm.com>
Date: Thu, 25 Apr 2002 17:17:24 -0500
From: Tom Gall <tom_gall@vnet.ibm.com>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.2 ppc)
X-Accept-Language: en
MIME-Version: 1.0
To: Santiago Garcia Mantinan <manty@manty.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: pcnet32 on 2.4.18 doesn't init on IBM rs/6000 B50 (powerpc)
In-Reply-To: <20020425220402.GA3654@man.beta.es>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Santiago,



Santiago Garcia Mantinan wrote:
<lots of PCnet 32 debug>
 
> I saw a patch for solving this but it is old, so I supposed it should be on
> this kernel (2.4.18), but it isn't, so I tried to apply it by hand as it
> doesn't work like it is. The resulting code didn't work either, I'll try to
> have a deeper look at it and see what I can find, but I think I did the
> proper changes acording to the original patch :-(

I'd recommend you grab the pcnet32 out of the larger ppc64 patch.
For pSeries (AKA Rs/6000) we have pcnet32 cards all over the place and
have
had to "fix" some things with the driver from time to time.  

See www.linuxppc64.org for the patches. 
(Grab say like the 2.4.18 patch, gunzip it and then
edit the patch by had, delete all the lives above and below 
the specific patch for pcnet32, save it and then apply that)

> If anybody has any clue on this I'd appreciate any help.

regards,

Tom

-- 
Tom Gall - [embedded] [PPC64 | PPC32] Code Monkey
Peace, Love &                  "Where's the ka-boom? There was
Linux Technology Center         supposed to be an earth
http://www.ibm.com/linux/ltc/   shattering ka-boom!"
(w) tom_gall@vnet.ibm.com       -- Marvin Martian
(w) 507-253-4558
(h) tgall@rochcivictheatre.org
