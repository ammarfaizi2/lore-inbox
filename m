Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318305AbSHUONi>; Wed, 21 Aug 2002 10:13:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318313AbSHUONL>; Wed, 21 Aug 2002 10:13:11 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:50621 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S318305AbSHUONF>;
	Wed, 21 Aug 2002 10:13:05 -0400
Date: Wed, 21 Aug 2002 16:14:45 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Vojtech Pavlik <vojtech@suse.cz>, Linus Torvalds <torvalds@transmeta.com>,
       Anton Altaparmakov <aia21@cantab.net>,
       Andre Hedrick <andre@linux-ide.org>, axboe@suse.de, bkz@linux-ide.org,
       linux-kernel@vger.kernel.org
Subject: Re: IDE?
Message-ID: <20020821161445.A4649@ucw.cz>
References: <Pine.SOL.3.96.1020817004411.25629B-100000@draco.cus.cam.ac.uk> <Pine.LNX.4.44.0208161706390.1674-100000@home.transmeta.com> <20020818131515.A15547@ucw.cz> <1029672964.15858.17.camel@irongate.swansea.linux.org.uk> <20020821121747.A3801@ucw.cz> <1029936007.26411.3.camel@irongate.swansea.linux.org.uk> <20020821152725.A4351@ucw.cz> <1029938778.26425.44.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1029938778.26425.44.camel@irongate.swansea.linux.org.uk>; from alan@lxorguk.ukuu.org.uk on Wed, Aug 21, 2002 at 03:06:18PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 21, 2002 at 03:06:18PM +0100, Alan Cox wrote:

> On Wed, 2002-08-21 at 14:27, Vojtech Pavlik wrote:
> > Even nicer? Easier to add new devices? Not having switch(deviceid)
> > everywhere? Don't know. I believe they're better. In any case it's a lot
> > of good work thrown away, yours or mine. :(
> 
> I don't mind a few deviceid switches. I don't find them annoying and
> I'll take the stability of using known good code with the daft bits like
> the rate filter while loop fixed over the unknowns of changing the code.
> 
> Once its in 2.4 and 2.5 and it works then I'm all ears, because at that
> point we can actively quantify and test for regressions

I can wait. I've done the rewrite back in 2000, so a couple more months ...
Also, I don't necessarily push it into 2.4. However, if you want to keep
a common IDE base in both, there is no other way.

-- 
Vojtech Pavlik
SuSE Labs
