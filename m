Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262808AbTAaWhB>; Fri, 31 Jan 2003 17:37:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262821AbTAaWhB>; Fri, 31 Jan 2003 17:37:01 -0500
Received: from tapu.f00f.org ([202.49.232.129]:19849 "EHLO tapu.f00f.org")
	by vger.kernel.org with ESMTP id <S262808AbTAaWhB>;
	Fri, 31 Jan 2003 17:37:01 -0500
Date: Fri, 31 Jan 2003 14:46:27 -0800
From: Chris Wedgwood <cw@f00f.org>
To: Larry McVoy <lm@bitmover.com>, bitkeeper-announce@bitmover.com,
       linux-kernel@vger.kernel.org
Subject: Re: [Bitkeeper-announce] Re: bkbits.net downtime
Message-ID: <20030131224627.GA1686@f00f.org>
References: <200301312114.h0VLEmC11997@work.bitmover.com> <20030131145018.N3904@schatzie.adilger.int>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030131145018.N3904@schatzie.adilger.int>
User-Agent: Mutt/1.3.28i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 31, 2003 at 02:50:18PM -0700, Andreas Dilger wrote:

> Actually, with BK it should be possible to have read only clones on
> multiple servers, should it not?  Not that I'm saying BK should foot
> the bill to do that, but having read-only clones of the primary
> kernel trees would avoid most downtime.

At the risk of suggesting something insanely complex...

... assuming BK read-only copies do work, why not actually have 'bk
pull' for hosts which can serve RO copies of the trees?  You
could use SRV records to locate these transparently to what has been
deployed now (I'm not really a fan of rfc2782.txt but nonetheless it
exists and others are using it, so it's a 'standard' of sorts).

Presumably doing something like this means you could have many people
voluntarily providing RO trees for different projects and lessen the
load on the bitmover infrastructure...



  --cw
