Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262916AbSJAWqZ>; Tue, 1 Oct 2002 18:46:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262917AbSJAWqZ>; Tue, 1 Oct 2002 18:46:25 -0400
Received: from tapu.f00f.org ([66.60.186.129]:58789 "EHLO tapu.f00f.org")
	by vger.kernel.org with ESMTP id <S262916AbSJAWqY>;
	Tue, 1 Oct 2002 18:46:24 -0400
Date: Tue, 1 Oct 2002 15:51:52 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Christoph Hellwig <hch@infradead.org>,
       Linus Torvalds <torvalds@transmeta.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.5.40 - and a feature freeze reminder
Message-ID: <20021001225152.GA26337@tapu.f00f.org>
References: <Pine.LNX.4.33.0210010021400.25527-100000@penguin.transmeta.com> <20021001221421.A7762@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021001221421.A7762@infradead.org>
User-Agent: Mutt/1.4i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 01, 2002 at 10:14:21PM +0100, Christoph Hellwig wrote:

> What about the 64bit sector_t (aka >2TB blockdevice) patches.  IMHO
> they're a must-have for 2.6 (people already ask for backporting them
> to 2.4..) and last time I check Peter had a BK tree with nicely
> split changesets.

Indeed.   I *really* would like to see this.


Consider a super-cheap IDE raid setup, 8x320GB drives for a single
filesystem. This means the files-system starts are 2.1TB (raid5, more
with raid0) and if you want to grow it...



  --cw (who has lots of DVDs to stream about the house)
