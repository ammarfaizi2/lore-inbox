Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261191AbSJLNhh>; Sat, 12 Oct 2002 09:37:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261205AbSJLNhh>; Sat, 12 Oct 2002 09:37:37 -0400
Received: from phoenix.infradead.org ([195.224.96.167]:30980 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S261191AbSJLNhg>; Sat, 12 Oct 2002 09:37:36 -0400
Date: Sat, 12 Oct 2002 14:43:22 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Christoph Hellwig <hch@infradead.org>, Alan Cox <alan@redhat.com>,
       Jens Axboe <axboe@suse.de>
Subject: Re: Linux v2.5.42
Message-ID: <20021012144322.A17332@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Linus Torvalds <torvalds@transmeta.com>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Alan Cox <alan@redhat.com>, Jens Axboe <axboe@suse.de>
References: <Pine.LNX.4.44.0210112134160.7166-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0210112134160.7166-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Fri, Oct 11, 2002 at 09:59:58PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 11, 2002 at 09:59:58PM -0700, Linus Torvalds wrote:
> 
> Augh.. People have been mailbombing me apparently because a lot of people 
> finally decided that they really want to sync with me due to the upcoming 
> feature freeze, so there's a _lot_ of stuff here, all over the map.

BTW, there's another infrastructure feature I forgot when you asked
what should go in before feature freeze.  And IMHO it's very important
(so why did I forget it..):  IBM's read copy update synchronisation
primitives.  They've shown significant improvements when used for the
file tables, dcache and routing cache, it has been around since before
2.5 forked, SuSE has it in their production kernel for a while, too and 
akpm has it in his tree for while.

Even if those existing users don't get in yet I don't want to miss the
infrastructure in the 2.6 series.

