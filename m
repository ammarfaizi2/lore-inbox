Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131268AbRCHDGZ>; Wed, 7 Mar 2001 22:06:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131269AbRCHDGF>; Wed, 7 Mar 2001 22:06:05 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:21009 "HELO
	postfix.conectiva.com.br") by vger.kernel.org with SMTP
	id <S131268AbRCHDFy>; Wed, 7 Mar 2001 22:05:54 -0500
Date: Wed, 7 Mar 2001 22:20:25 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Jesse Pollard <jesse@cats-chateau.net>
Cc: Tom Sightler <ttsig@tuxyturvy.com>, linux-kernel@vger.kernel.org
Subject: Re: Questions about Enterprise Storage with Linux
In-Reply-To: <01030720460701.06635@tabby>
Message-ID: <Pine.LNX.4.21.0103072216250.867-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 7 Mar 2001, Jesse Pollard wrote:

> On Wed, 07 Mar 2001, Tom Sightler wrote:
> >Hi All,
> >
> >I'm seeking information in regards to a large Linux implementation we are
> >planning.  We have been evaluating many storage options and I've come up
> >with some questions that I have been unable to answer as far as Linux
> >capabilities in regards to storage.
> >
> >We are looking at storage systems that provide approximately 1TB of capacity
> >for now and can scale to 10+TB in the future.  We will almost certainly use
> >a storage system that provides both fiber channel connectivity as well as
> >NFS connectivity.
> >
> >The questions that have been asked are as follows (assume 2.4.x kernels):
> >
> >1.  What is the largest block device that linux currently supports?  i.e.
> >Can I create a single 1TB volume on my storage device and expect linux to
> >see it and be able to format it?
> 
> Checkout the GFS project for really large filesystems with a high capability
> of "fail safe" configuration.
> 
> The block/file limits are more determined by the size of the hosts. Alpha/Sparc
> based systems use 64 bit operations, Intel/AMD use 32 bit. It also depends
> on usage of the sign bit in the drivers. Most 32bit systems are limited
> to 1 TB (depending on the driver of course - some allow for 2 TB).

Even on 64-bit architectures the hard upper limit is 2TB. (32-bit block
numbers)



