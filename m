Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311749AbSD1QpK>; Sun, 28 Apr 2002 12:45:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311752AbSD1QpJ>; Sun, 28 Apr 2002 12:45:09 -0400
Received: from 213-96-224-204.uc.nombres.ttd.es ([213.96.224.204]:52744 "EHLO
	manty.net") by vger.kernel.org with ESMTP id <S311749AbSD1QpJ>;
	Sun, 28 Apr 2002 12:45:09 -0400
Date: Sun, 28 Apr 2002 18:45:07 +0200
From: Santiago Garcia Mantinan <manty@manty.net>
To: Tom Gall <tom_gall@vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: pcnet32 on 2.4.18 doesn't init on IBM rs/6000 B50 (powerpc)
Message-ID: <20020428164506.GA3007@man.beta.es>
In-Reply-To: <20020425220402.GA3654@man.beta.es> <3CC88074.D6F112E6@vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'd recommend you grab the pcnet32 out of the larger ppc64 patch.
> For pSeries (AKA Rs/6000) we have pcnet32 cards all over the place and
> have
> had to "fix" some things with the driver from time to time.  

Same experience as with 2.4.19pre7 that I descrived on my previous mail to
Anton Blanchard and the list, have a look at it for details. The card is
well detected but packages are being lost (this only happens when the
machine is booted from the net, just like in 2.4.18). If nobody else sees
this maybe it is a problem with the release of this openfirmware which just
fucks the card when using it :-?

Thanks a lot!
-- 
Manty/BestiaTester -> http://manty.net
