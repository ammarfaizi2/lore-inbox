Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283786AbRLEQRo>; Wed, 5 Dec 2001 11:17:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283759AbRLEQRb>; Wed, 5 Dec 2001 11:17:31 -0500
Received: from stat8.steeleye.com ([63.113.59.41]:16900 "EHLO
	fenric.sc.steeleye.com") by vger.kernel.org with ESMTP
	id <S283770AbRLEQQS>; Wed, 5 Dec 2001 11:16:18 -0500
Date: Wed, 5 Dec 2001 11:14:43 -0500 (EST)
From: Paul Clements <kernel@steeleye.com>
Reply-To: Paul.Clements@steeleye.com
To: Edward Muller <emuller@learningpatterns.com>
cc: Paul.Clements@steeleye.com, linux-kernel@vger.kernel.org
Subject: Re: Current NBD 'stuff'
In-Reply-To: <1007507560.4520.19.camel@akira.learningpatterns.com>
Message-ID: <Pine.LNX.4.10.10112051058140.17617-100000@clements.sc.steeleye.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4 Dec 2001, Edward Muller wrote:

> Actually I am playing with ENBD now.

Yep. I've looked at that too.

> I think ENBD is targeted for inclusion in the kernel in 2.5, but it can
> be found seperatly (sp) at http://www.it.uc3m.es/~ptb/nbd/
> 
> It looks much better than the nbd stuff that is currently in the kernel.

A word of caution on this. I played around with ENBD (as well as some
others) about 6 months ago. I also did some performance testing with
the different drivers and user-level utilities. What I found was that
ENBD achieved only about 1/3 ~ 1/4 the throughput of NBD (even with
multiple replication paths and various block sizes). YMMV.
I also looked at DRBD, which performed pretty well (comparable to NBD).

> But that's mostly because Pavel doesn't have much time at the moment for
> it AFAIK.

Yeah. I wish I had the time to develop/maintain a network block 
device driver myself...but unfortunately I don't... :/

-- 
Paul Clements
Paul.Clements@SteelEye.com

