Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261332AbSI3VVX>; Mon, 30 Sep 2002 17:21:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261335AbSI3VVX>; Mon, 30 Sep 2002 17:21:23 -0400
Received: from zok.SGI.COM ([204.94.215.101]:51348 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S261332AbSI3VVW>;
	Mon, 30 Sep 2002 17:21:22 -0400
Date: Tue, 1 Oct 2002 07:26:27 +1000
From: Nathan Scott <nathans@sgi.com>
To: L A Walsh <law@tlinx.org>
Cc: Linux-Xfs <linux-xfs@oss.sgi.com>,
       Linux-Kernel <linux-kernel@vger.kernel.org>,
       Linux-Fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: block size in XFS = hard coded constant?
Message-ID: <20021001072627.A218954@wobbly.melbourne.sgi.com>
References: <1033336748.1088.4.camel@laptop.americas.sgi.com> <NFBBKNPJLGIDJFAHGKMBIEIJCDAA.law@tlinx.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <NFBBKNPJLGIDJFAHGKMBIEIJCDAA.law@tlinx.org>; from law@tlinx.org on Mon, Sep 30, 2002 at 01:55:38AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Mon, Sep 30, 2002 at 01:55:38AM -0700, L A Walsh wrote:
> Right -- I know it isn't the filesystem block size.
> 
> In this day and age, it seems anachronistic.  Given the 10% higher block
> density, not only would it yield higher capacities, but should yield higher
> transfer rates, no?
> 
> I know it isn't a simple constant switch -- but I wouldn't want to switch
> constants since not all disks should be constrained to the same block size.
> 

I have some code which implements an initial version of >512 byte sector
sizes for the XFS data device - I was just chatting about this with Steve
today.  Initial benchmarking results seem to suggest that it does indeed
perform slightly better.  Support for this will likely be making its way
into XFS in the future, but not right away.

cheers.

-- 
Nathan
