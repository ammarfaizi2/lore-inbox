Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292302AbSBBPZY>; Sat, 2 Feb 2002 10:25:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292303AbSBBPZP>; Sat, 2 Feb 2002 10:25:15 -0500
Received: from 216-42-72-147.ppp.netsville.net ([216.42.72.147]:15522 "EHLO
	roc-24-169-102-121.rochester.rr.com") by vger.kernel.org with ESMTP
	id <S292302AbSBBPZK>; Sat, 2 Feb 2002 10:25:10 -0500
Date: Sat, 02 Feb 2002 10:24:20 -0500
From: Chris Mason <mason@suse.com>
To: Chris Wedgwood <cw@f00f.org>, Steve Lord <lord@sgi.com>
cc: Andrew Morton <akpm@zip.com.au>, Ricardo Galli <gallir@uib.es>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: O_DIRECT fails in some kernel and FS
Message-ID: <211490000.1012663460@tiny>
In-Reply-To: <20020202093554.GA7207@tapu.f00f.org>
In-Reply-To: <E16WkQj-0005By-00@antoli.uib.es> <3C5AFE2D.95A3C02E@zip.com.au> <1012597538.26363.443.camel@jen.americas.sgi.com> <20020202093554.GA7207@tapu.f00f.org>
X-Mailer: Mulberry/2.1.0 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Saturday, February 02, 2002 01:35:56 AM -0800 Chris Wedgwood <cw@f00f.org> wrote:

> On Fri, Feb 01, 2002 at 03:05:38PM -0600, Steve Lord wrote:
> 
>     > ext2 is the only filesystem which has O_DIRECT support.
> 
>     And XFS ;-)
> 
> I sent reiserfs O_DIRECT support patches to someone a while ago.  I
> can look to ressurect these (assuming I can find them!)
> 
> Chris Mason is always going to be a better source for these anyhow, he
> certainly understands any complex nuances there may be.  Chris, do you
> have any cycles to comment on this please?

I've dug your patch out of my archives, it should be safer now that
we've got the expanding truncate patch into the kernel (2.2.18pre).  
I'm porting it forward now.

thanks,
chris

