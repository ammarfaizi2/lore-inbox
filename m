Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315758AbSFCXMM>; Mon, 3 Jun 2002 19:12:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315760AbSFCXMK>; Mon, 3 Jun 2002 19:12:10 -0400
Received: from pD9E23450.dip.t-dialin.net ([217.226.52.80]:12683 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S315758AbSFCXMF>; Mon, 3 Jun 2002 19:12:05 -0400
Date: Mon, 3 Jun 2002 17:11:46 -0600 (MDT)
From: Thunder from the hill <thunder@ngforever.de>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Scott Murray <scottm@somanetworks.com>
cc: Lightweight patch manager <patch@luckynet.dynu.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>,
        Zwane Mwaikambo <zwane@linux.realnet.co.sz>
Subject: Re: [PATCH][2.5] Port opl3sa2 changes from 2.4
In-Reply-To: <Pine.LNX.4.33.0206031846520.5598-100000@rancor.yyz.somanetworks.com>
Message-ID: <Pine.LNX.4.44.0206031709370.3833-100000@hawkeye.luckynet.adm>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 3 Jun 2002, Scott Murray wrote:
> I think it would be better to wait until Zwane sends something to Alan
> and/or Marcelo, as this patch is incorrect on a couple of levels.  See my
> annotations below:

His patch won't match for 2.5. I just adapted it, even though I've had a 
typo there.

> > +		opl3sa2_state[card].activated = 1;
> 
> This line should really be below the following if statement, as I believe
> Zwane mentioned to Gerald.

You could of course have it there. No problem with that.

> I think always blindly remapping the the DMA channels to 0 and 1 is a bad
> idea and will likely break things for some people.  It would be better if
> the core isapnp code could be made smarter, but a simple alternative would
> be to rework the opl3sa2 module parameter parsing to allow using the DMA
> parameters as an override when using PnP.

As I mentioned, I was just porting it.

> Scott

Regards,
Thunder
-- 
ship is leaving right on time	|	Thunder from the hill at ngforever
empty harbour, wave goodbye	|
evacuation of the isle		|	free inhabitant not directly
caveman's paintings drowning	|	belonging anywhere

