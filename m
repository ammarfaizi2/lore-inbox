Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290591AbSARD6r>; Thu, 17 Jan 2002 22:58:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290592AbSARD6h>; Thu, 17 Jan 2002 22:58:37 -0500
Received: from cx97923-a.phnx3.az.home.com ([24.1.197.194]:64478 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S290591AbSARD6Q>;
	Thu, 17 Jan 2002 22:58:16 -0500
Message-ID: <3C479D4E.1010908@candelatech.com>
Date: Thu, 17 Jan 2002 20:58:06 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20011019 Netscape6/6.2
X-Accept-Language: en-us
MIME-Version: 1.0
To: David Lang <david.lang@digitalinsight.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Tulip driver bug in 2.4.17 (fwd)
In-Reply-To: <Pine.LNX.4.40.0201171733460.26448-100000@dlang.diginsite.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



David Lang wrote:

> On Thu, 17 Jan 2002, Ben Greear wrote:
> 
> 
>>You're not using a PCI extender/riser card, are you?
>>
> 
> Yes, (it's in a 2u rackmount case). it's a low right-angle extender


You're screwed :)

It seems to be a hardware/PCI problem.  I replaced 4-port NICS (the DFE-570-TX),
motherboards, cpus, entire chassis...the problem followed the riser cards.

To debug, take off the face-plates of your NICS and run them in your box
w/out the riser..or take the MB completely out of the case.  I'll bet
you a dozen realtec nics that that will fix your lockup problem! :)

While you're doing that...order a $54 riser from adexelec.com.  Their
riser fixed the problem for me.  If the riser isn't obvious on
Adex's page, let me know and I'll find the version of the one I got.

Btw, if you find a butter-fly riser for a 1U chassis that works, let
me know..cause I see the same problem in my 1U servers...

Enjoy,
Ben


-- 
Ben Greear <greearb@candelatech.com>       <Ben_Greear AT excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear


