Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274438AbRITMIv>; Thu, 20 Sep 2001 08:08:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274443AbRITMIl>; Thu, 20 Sep 2001 08:08:41 -0400
Received: from hank-fep8-0.inet.fi ([194.251.242.203]:7379 "EHLO
	fep08.tmt.tele.fi") by vger.kernel.org with ESMTP
	id <S274438AbRITMI1>; Thu, 20 Sep 2001 08:08:27 -0400
Message-ID: <3BA9DC30.DA46A008@pp.inet.fi>
Date: Thu, 20 Sep 2001 15:08:16 +0300
From: Jari Ruusu <jari.ruusu@pp.inet.fi>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.2.19aa2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: "steve j. kondik" <shade@chemlab.org>, linux-kernel@vger.kernel.org
Subject: Re: encrypted swap on loop in 2.4.10-pre12?
In-Reply-To: <1000912739.17522.2.camel@discord> <3BA907F6.3586811C@pp.inet.fi> <20010920081353.H588@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> On Thu, Sep 20 2001, Jari Ruusu wrote:
> > Cryptoapi can't be used to encrypt swap. It has nasties like sleeping in
> > make_request_fn() and potential memory allocation deadlock.
> 
> sleeping in make_request_fn is not a nasty in itself, btw. in fact loop
> just needs an emergency page pool for swap to be perfectly safe.

loop-AES provides emergency page pool for device backed loop. Take a look.

Regards,
Jari Ruusu <jari.ruusu@pp.inet.fi>

