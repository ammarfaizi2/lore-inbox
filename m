Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315918AbSEGRt1>; Tue, 7 May 2002 13:49:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315919AbSEGRt0>; Tue, 7 May 2002 13:49:26 -0400
Received: from 12-224-36-73.client.attbi.com ([12.224.36.73]:1796 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S315918AbSEGRtZ>;
	Tue, 7 May 2002 13:49:25 -0400
Date: Tue, 7 May 2002 09:49:43 -0700
From: Greg KH <greg@kroah.com>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: torvalds@transmeta.com, mochel@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [BK PATCH] PCI reorg changes for 2.5.14
Message-ID: <20020507164942.GA626@kroah.com>
In-Reply-To: <20020506222506.GA8718@kroah.com> <20020507201511.A766@jurassic.park.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.26i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Tue, 09 Apr 2002 15:41:01 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 07, 2002 at 08:15:11PM +0400, Ivan Kokshaysky wrote:
> On Mon, May 06, 2002 at 03:25:07PM -0700, Greg KH wrote:
> > Here is a series of changesets that reorganize the core and i386 PCI
> > files.  It splits the current big files up into smaller pieces,
> > according to the different function and platform type (removing lots of
> > #ifdefs in the process.)  Pat Mochel did 99.9% of this work, and I've
> > tested it out and forward ported it to your most recent kernel version.
> 
> There are missing #includes which will break compilation on some non-x86
> platforms. With following patch this compiles and works on alpha.

I've added this patch, and both Pat and I moved the files into the
different directory name.  I'll test this all out and send an updated
patch later today.

thanks,

greg k-h
