Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261746AbTCLPyS>; Wed, 12 Mar 2003 10:54:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261751AbTCLPyR>; Wed, 12 Mar 2003 10:54:17 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:50884
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261746AbTCLPyQ>; Wed, 12 Mar 2003 10:54:16 -0500
Subject: Re: bio too big device
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jens Axboe <axboe@suse.de>
Cc: Andre Hedrick <andre@linux-ide.org>,
       scott thomason <scott-kernel@thomasons.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030312151117.GH834@suse.de>
References: <20030312085145.GJ811@suse.de>
	 <Pine.LNX.4.10.10303120100490.391-100000@master.linux-ide.org>
	 <20030312090943.GA3298@suse.de>
	 <1047485697.22696.23.camel@irongate.swansea.linux.org.uk>
	 <20030312151117.GH834@suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1047489166.22694.44.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 12 Mar 2003 17:12:47 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-03-12 at 15:11, Jens Axboe wrote:
> Then go with 128. I'd like to stress again that _if_ you get worse
> performance it's not due to the request being a bit smaller, but indeed
> because 248 can cause badly aligned requests.
> 
> > got the IDE layer using 256 block writes even if we have to limit it
> > to more modern drives by some handwaving (8Gb+ say)
> 
> Does Windows use 256 sector requests or not? If not, then I'd sure don't
> want to do it in Linux, the handwaving doesn't mean anything then.

I am told it does, Andre can you confirm this either way. If not then its
time to ask vendors to confirm and any vendor who says "our drives are fine"
we put on the ok list.

