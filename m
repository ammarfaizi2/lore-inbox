Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132828AbRDPBY7>; Sun, 15 Apr 2001 21:24:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132823AbRDPBYs>; Sun, 15 Apr 2001 21:24:48 -0400
Received: from zmailer.org ([194.252.70.162]:3090 "EHLO zmailer.org")
	by vger.kernel.org with ESMTP id <S132824AbRDPBYf>;
	Sun, 15 Apr 2001 21:24:35 -0400
Date: Mon, 16 Apr 2001 04:24:15 +0300
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: David Findlay <david_j_findlay@yahoo.com.au>
Cc: "Mike A. Harris" <mharris@opensourceadvocate.org>,
        linux-kernel@vger.kernel.org
Subject: Re: IP Acounting Idea for 2.5
Message-ID: <20010416042415.A805@mea-ext.zmailer.org>
In-Reply-To: <Pine.LNX.4.33.0104152039130.1616-100000@asdf.capslock.lan> <01041708461209.00352@workshop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01041708461209.00352@workshop>; from david_j_findlay@yahoo.com.au on Tue, Apr 17, 2001 at 08:46:12AM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 17, 2001 at 08:46:12AM +1000, David Findlay wrote:
> On Monday 16 April 2001 10:40, you wrote:
> > Perhaps I misunderstand what it is exactly you are trying to do,
> > but I would think that this could be done entirely in userland by
> > software that just adds rules for you instead of you having to do
> > it manually.
> 
> I suppose, but it would be so much easier if the kernel did it automatically. 
> Having a rule to go through for each IP address to be logged would be slower 
> than implementing one rule that would log all of them. Doing this in the 
> kernel would improve preformance.

	Perhaps "netflow" would be an answer ?

	It is cisco idea for collecting accounting data for
	network flows.   System has a cache of flows for
	which it collects data, and once the cache overflows
	(or flow times out), data is sent to designated flow
	collection server(s).

http://www.cisco.com/warp/public/cc/pd/iosw/ioft/neflct/tech/napps_wp.htm

> David

/Matti Aarnio
