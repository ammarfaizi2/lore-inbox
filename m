Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276309AbRJKN2X>; Thu, 11 Oct 2001 09:28:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276350AbRJKN2N>; Thu, 11 Oct 2001 09:28:13 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:64439 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S276309AbRJKN2B>;
	Thu, 11 Oct 2001 09:28:01 -0400
Date: Thu, 11 Oct 2001 09:28:31 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: =?iso-8859-1?Q?Stefan_Smietanowski?= <stesmi@stesmi.com>
cc: v.sweeney@dexterus.com, linux-kernel@vger.kernel.org
Subject: Re: =?iso-8859-1?Q?Re:_[PATCH]_Re:_Lost_Partition?=
In-Reply-To: <62283.212.247.172.29.1002806753.squirrel@webmail.stesmi.com>
Message-ID: <Pine.GSO.4.21.0110110927390.22698-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 11 Oct 2001, [iso-8859-1] Stefan Smietanowski wrote:

> Hi. Re partition problem.
> 
> 
> > -	unsigned long first_sector, first_size, this_sector, this_size;
> > +	unsigned long first_sector, this_sector, this_size;
> 
> > +	this_size = first_size;
> 
> 
> It seems that's sorta wrong, no?
> 
> You just removed "first_size" and then you access it :)

Look carefully at the arguments list.  first_size had just become explicitly
passed to extended_partition().

