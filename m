Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266851AbSLPKaW>; Mon, 16 Dec 2002 05:30:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266854AbSLPKaW>; Mon, 16 Dec 2002 05:30:22 -0500
Received: from louise.pinerecords.com ([213.168.176.16]:49806 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S266851AbSLPKaV>; Mon, 16 Dec 2002 05:30:21 -0500
Date: Mon, 16 Dec 2002 11:38:12 +0100
From: Tomas Szepe <szepe@pinerecords.com>
To: Joe Thornber <joe@fib011235813.fsnet.co.uk>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 6/19
Message-ID: <20021216103812.GB20223@louise.pinerecords.com>
References: <20021211121749.GA20782@reti> <Pine.LNX.4.44.0212151649180.2445-100000@home.transmeta.com> <20021216100457.GA7407@reti> <20021216100947.GG7407@reti> <20021216103558.GA20223@louise.pinerecords.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021216103558.GA20223@louise.pinerecords.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > +	/*
> > +	 * chunk_size is a power of two
> > +	 */
> > +	if (!chunk_size || (chunk_size & (chunk_size - 1))) {
> > +		ti->error = "dm-stripe: Invalid chunk size";
> > +		return -EINVAL;
> > +	}
> 
> Is 1 a valid chunksize then?  [It certainly is not a power of two. ;)]

Umm, 2 ^ 0 = 1.  Sorry.

-- 
Tomas Szepe <szepe@pinerecords.com>
