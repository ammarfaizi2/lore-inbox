Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284772AbRLEWdA>; Wed, 5 Dec 2001 17:33:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284771AbRLEWcs>; Wed, 5 Dec 2001 17:32:48 -0500
Received: from stat8.steeleye.com ([63.113.59.41]:39942 "EHLO
	fenric.sc.steeleye.com") by vger.kernel.org with ESMTP
	id <S284769AbRLEWcf>; Wed, 5 Dec 2001 17:32:35 -0500
Date: Wed, 5 Dec 2001 17:30:46 -0500 (EST)
From: Paul Clements <kernel@steeleye.com>
Reply-To: Paul.Clements@steeleye.com
To: "Peter T. Breuer" <ptb@it.uc3m.es>
cc: Paul.Clements@steeleye.com, Edward Muller <emuller@learningpatterns.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Current NBD 'stuff'
In-Reply-To: <200112052102.WAA29674@nbd.it.uc3m.es>
Message-ID: <Pine.LNX.4.10.10112051714090.17617-100000@clements.sc.steeleye.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Dec 2001, Peter T. Breuer wrote:

> It strikes me that possibly you were using the 2.2 kernel. 

Yes, the performance tests were on 2.2 -- and surely things have changed 
in 2.4 -- most notably, as you mention, the request merging stuff.


> But in general I find that Enbd goes
> either at the speed of the net or at the speed of the remote disk,
> whichever is slower.

Well, that's as good as it gets. I had noticed that NBD on 2.2 was
also capable of writing at speeds just under the TCP bandwidth with
100Mb/s ethernet. (I wonder if it would scale nicely to 1Gb/s?)

--
Paul Clements
Paul.Clements@SteelEye.com

