Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263957AbTE3U1g (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 May 2003 16:27:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263978AbTE3U1g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 May 2003 16:27:36 -0400
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:32416 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S263957AbTE3U1f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 May 2003 16:27:35 -0400
Date: Fri, 30 May 2003 22:40:55 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Steven Cole <elenstev@mesatop.com>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH] 2.5 Documentation/CodingStyle ANSI C function declarations.
Message-ID: <20030530204055.GB3308@wohnheim.fh-wedel.de>
References: <1054324633.3754.119.camel@spc9.esa.lanl.gov> <20030530201429.GA3308@wohnheim.fh-wedel.de> <1054326307.3751.124.camel@spc9.esa.lanl.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1054326307.3751.124.camel@spc9.esa.lanl.gov>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 May 2003 14:25:07 -0600, Steven Cole wrote:
> On Fri, 2003-05-30 at 14:14, Jörn Engel wrote:
> > On Fri, 30 May 2003 13:57:13 -0600, Steven Cole wrote:
> > > 
> > > Maybe the following should be unnecessary after all these years since
> > > the ANSI C standard was introduced, but several files associated with
> > > zlib were using the old-style function declaration.
> > 
> > In the case of the zlib, just leave it as it is.  The less changes we
> > make, to easier it is to merge upstream changes into the kernel.
> 
> Whoops, sorry.  Linus started the old-style to new-style conversion in
> zlib_inflate a few days ago, and I've sent Linus several patches
> finishing the job in zlib_deflate and elsewhere.  Some are already in
> the tree.

I would agree with that strategy, if the zlib wasn't actively
maintained anymore and we'd have to take over that part anyway.  But
as it is, this will create extra work with little bonus on our side,
except to set a better example maybe.

Linus, any insight to your reasons for this change?

Jörn

-- 
Rules of Optimization:
Rule 1: Don't do it.
Rule 2 (for experts only): Don't do it yet.
-- M.A. Jackson 
