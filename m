Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286521AbSBRVPM>; Mon, 18 Feb 2002 16:15:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286590AbSBRVPC>; Mon, 18 Feb 2002 16:15:02 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:8695
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S286521AbSBRVOv>; Mon, 18 Feb 2002 16:14:51 -0500
Date: Mon, 18 Feb 2002 13:14:53 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Hans Reiser <reiser@namesys.com>
Cc: William Lee Irwin III <wli@holomorphy.com>,
        Anish Srivastava <anish@bidorbuyindia.com>,
        linux-kernel@vger.kernel.org, edward@thebsh.namesys.com
Subject: Re: File BlockSize
Message-ID: <20020218211453.GA20336@matchmail.com>
Mail-Followup-To: Hans Reiser <reiser@namesys.com>,
	William Lee Irwin III <wli@holomorphy.com>,
	Anish Srivastava <anish@bidorbuyindia.com>,
	linux-kernel@vger.kernel.org, edward@thebsh.namesys.com
In-Reply-To: <002e01c1b397$1a26d270$3c00a8c0@baazee.com> <20020212075203.GF767@holomorphy.com> <3C6E08FB.7030308@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C6E08FB.7030308@namesys.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 16, 2002 at 10:23:39AM +0300, Hans Reiser wrote:
> William Lee Irwin III wrote:
> 
> >On Tue, Feb 12, 2002 at 01:00:07PM +0530, Anish Srivastava wrote:
> >
> >>Hi!!
> >>Is there any way I can have 8K block sizes in ext2, reiserfs or ext3.
> >>I am trying to install Oracle on Linux with 8K DB_Block_size.
> >>But it gives me a Block size mismatch saying that the File BlockSize is 
> >>only
> >>4K
> >>Maybe, there is a kernel patch available which enables Linux to create 8K
> >>file blocks.
> >>Thanks in anticipation....
> >>
> >
> >Unfortunately filesystem block sizes larger than PAGE_SIZE are unsupported.
> >I wish they were, though.

I believe that is _page cache_ size instead of PAGE_SIZE.  Though,
page_cache_size is based on PAGE_SIZE...

> >
> I should be more precise, on alpha you can do it with reiserfs.
> 
> Hans

And ext2 and ext3 and ...
