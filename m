Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290802AbSAYTXv>; Fri, 25 Jan 2002 14:23:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290803AbSAYTXk>; Fri, 25 Jan 2002 14:23:40 -0500
Received: from tux.gsfc.nasa.gov ([128.183.191.134]:36819 "EHLO
	tux.gsfc.nasa.gov") by vger.kernel.org with ESMTP
	id <S290802AbSAYTX0>; Fri, 25 Jan 2002 14:23:26 -0500
Date: Fri, 25 Jan 2002 14:23:23 -0500
From: John Kodis <kodis@mail630.gsfc.nasa.gov>
To: Christoph Hellwig <hch@ns.caldera.de>
Cc: palmerj@zanshin.gsfc.nasa.gov, linux-kernel@vger.kernel.org
Subject: Re: Mounting OS-X "Unix" filesystems on Linux
Message-ID: <20020125192323.GA26441@tux.gsfc.nasa.gov>
Mail-Followup-To: John Kodis <kodis@mail630.gsfc.nasa.gov>,
	Christoph Hellwig <hch@ns.caldera.de>,
	palmerj@zanshin.gsfc.nasa.gov, linux-kernel@vger.kernel.org
In-Reply-To: <20020125171837.GA31376@tux.gsfc.nasa.gov> <200201251859.g0PIxQb29093@ns.caldera.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200201251859.g0PIxQb29093@ns.caldera.de>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 25, 2002 at 07:59:26PM +0100, Christoph Hellwig wrote:

> MacOSX uses two main filesystem types:
> 
> 	HFS+	filesystem of the old MacOS
> 	UFS/FFS	the BSD fast filling system.
> 
> The first one is not supported at all by the stock Linux tree, but I
> think an eraly implementation exists out-of-tree.
> For UFS there is support in the current kernel, although it is slightly
> buggy and eats filesystems when writing.  There are many ufs subtypes,
> and I'm not sure whether OSX supports 4.4BSD-style or OpenStep-style
> ones.  You should try both (ufstype=44bsd or ufstype=openstep mount
> options).

That's what I was missing.  I can mount a Mac OS-X "Unix" filesystem
on the Linux 2.4.9-7 kernel supplied with RHL 7.2, but I have to
specify a type of ufs and supply both the ro and ufstype=openstep
options to the mount command.  Too bad about the lack of write
support, but I'm sure someone out there is working on that.  Thanks
for your help.

-- 
John Kodis                                    Goddard Space Flight Center
kodis@mail630.gsfc.nasa.gov                      Greenbelt, Maryland, USA
Phone: 301-286-7376                                     Fax: 301-286-1771
