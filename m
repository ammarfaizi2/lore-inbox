Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274451AbRITM0M>; Thu, 20 Sep 2001 08:26:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274448AbRITM0D>; Thu, 20 Sep 2001 08:26:03 -0400
Received: from fe100.worldonline.dk ([212.54.64.211]:53520 "HELO
	fe100.worldonline.dk") by vger.kernel.org with SMTP
	id <S274453AbRITMZs>; Thu, 20 Sep 2001 08:25:48 -0400
Date: Thu, 20 Sep 2001 14:25:55 +0200
From: Jens Axboe <axboe@suse.de>
To: Jari Ruusu <jari.ruusu@pp.inet.fi>
Cc: "steve j. kondik" <shade@chemlab.org>, linux-kernel@vger.kernel.org
Subject: Re: encrypted swap on loop in 2.4.10-pre12?
Message-ID: <20010920142555.B588@suse.de>
In-Reply-To: <1000912739.17522.2.camel@discord> <3BA907F6.3586811C@pp.inet.fi> <20010920081353.H588@suse.de> <3BA9DC30.DA46A008@pp.inet.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3BA9DC30.DA46A008@pp.inet.fi>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 20 2001, Jari Ruusu wrote:
> Jens Axboe wrote:
> > On Thu, Sep 20 2001, Jari Ruusu wrote:
> > > Cryptoapi can't be used to encrypt swap. It has nasties like sleeping in
> > > make_request_fn() and potential memory allocation deadlock.
> > 
> > sleeping in make_request_fn is not a nasty in itself, btw. in fact loop
> > just needs an emergency page pool for swap to be perfectly safe.
> 
> loop-AES provides emergency page pool for device backed loop. Take a look.

Then sleeping in make_request_fn is not a nasty at all. In fact the
kernel does it all the time anyways.

-- 
Jens Axboe

