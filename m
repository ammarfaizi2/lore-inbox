Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310472AbSCBWZX>; Sat, 2 Mar 2002 17:25:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310473AbSCBWZN>; Sat, 2 Mar 2002 17:25:13 -0500
Received: from tapu.f00f.org ([66.60.186.129]:36747 "EHLO tapu.f00f.org")
	by vger.kernel.org with ESMTP id <S310472AbSCBWYy>;
	Sat, 2 Mar 2002 17:24:54 -0500
Date: Sat, 2 Mar 2002 14:24:51 -0800
From: Chris Wedgwood <cw@f00f.org>
To: Matti Aarnio <matti.aarnio@zmailer.org>
Cc: Doug McNaught <doug@wireboard.com>,
        "Doug O'Neil" <DougO@seven-systems.com>,
        lk <linux-kernel@vger.kernel.org>
Subject: Re: LFS Support for Sendfile
Message-ID: <20020302222451.GB9590@tapu.f00f.org>
In-Reply-To: <036801c1bfee$b5b0f780$1801010a@Mauser> <m34rk2tn7h.fsf@varsoon.denali.to> <20020228100325.O23151@mea-ext.zmailer.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020228100325.O23151@mea-ext.zmailer.org>
User-Agent: Mutt/1.3.27i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 28, 2002 at 10:03:25AM +0200, Matti Aarnio wrote:

    The API (kernel syscall) as defined does not support LFS.

I wonder does it really need to?  I mean, a loop calling sendfile for
2GB (or whatever) at a time is almost as good, if not better in some
ways.

    The "extent based" filesystems offer flatter performance, and
    while I can't determine if ReiserFS is exactly of that type, it
    too offers fast and flat performance.

Reiserfs (v3) isn't extent based but does perform pretty well.  When I
was messing large numbers of with (what at the time were) large files
of 50GB or so, XFS proved to be very effective.


  --cw
