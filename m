Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262520AbSJAVI4>; Tue, 1 Oct 2002 17:08:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262523AbSJAVI4>; Tue, 1 Oct 2002 17:08:56 -0400
Received: from carisma.slowglass.com ([195.224.96.167]:43792 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S262520AbSJAVIz>; Tue, 1 Oct 2002 17:08:55 -0400
Date: Tue, 1 Oct 2002 22:14:21 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.5.40 - and a feature freeze reminder
Message-ID: <20021001221421.A7762@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Linus Torvalds <torvalds@transmeta.com>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.33.0210010021400.25527-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.33.0210010021400.25527-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Tue, Oct 01, 2002 at 12:32:47AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 01, 2002 at 12:32:47AM -0700, Linus Torvalds wrote:
> you _should_ also test this code out even before the freeze. The IDE layer
> shouldn't be all that scary any more, and while there are still silly
> things like trivially non-compiling setups etc, it's generally a good idea
> to try things out as widely as possible before it's getting too late to
> complain about things..

What about the 64bit sector_t (aka >2TB blockdevice) patches.  IMHO they're
a must-have for 2.6 (people already ask for backporting them to 2.4..) and
last time I check Peter had a BK tree with nicely split changesets.

