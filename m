Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265612AbTBFEOw>; Wed, 5 Feb 2003 23:14:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265637AbTBFEOe>; Wed, 5 Feb 2003 23:14:34 -0500
Received: from blowme.phunnypharm.org ([65.207.35.140]:41489 "EHLO
	blowme.phunnypharm.org") by vger.kernel.org with ESMTP
	id <S265612AbTBFENv>; Wed, 5 Feb 2003 23:13:51 -0500
Date: Wed, 5 Feb 2003 23:23:03 -0500
From: Ben Collins <bcollins@debian.org>
To: Larry McVoy <lm@work.bitmover.com>, Andrea Arcangeli <andrea@e-mind.com>,
       linux-kernel@vger.kernel.org
Subject: Re: openbkweb-0.0
Message-ID: <20030206042303.GB523@phunnypharm.org>
References: <20030206021029.GW19678@dualathlon.random> <20030206030908.GA26137@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030206030908.GA26137@work.bitmover.com>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 05, 2003 at 07:09:08PM -0800, Larry McVoy wrote:
> If people start using this against the bkbits.net server, we'll be
> forced to shut down http access.  We can't afford the bandwidth costs,
> we get charged per byte after a certain amount.
> 
> I'm not saying this new code isn't the most wonderful thing since sliced
> bread, I'm saying that programatic access to the http servers on bkbits is
> absolutely not supported and excessive bandwidth means we shut that down.
> 
> Sorry, but getting at the data this way is very bandwidth intensive and
> we can't pay for it.  If you use BK to get the data it is easily 1/1000th
> of the amount of bandwidth these scripts use.  If someone wants to foot
> the bandwidth bill, it is currently $950/month.

You may want to enable mod_deflate, and then scripts can easily make use
of gzip compressed data. May not be an end-all, but something to
consider.

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
Deqo       - http://www.deqo.com/
