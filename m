Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964979AbVITLnJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964979AbVITLnJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 07:43:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964980AbVITLnI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 07:43:08 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:35399 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S964979AbVITLnH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 07:43:07 -0400
Date: Tue, 20 Sep 2005 13:42:54 +0200
From: Jens Axboe <axboe@suse.de>
To: Hans Reiser <reiser@namesys.com>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       thenewme91@gmail.com, Christoph Hellwig <hch@infradead.org>,
       Denis Vlasenko <vda@ilport.com.ua>, chriswhite@gentoo.org,
       lkml <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>,
       Nate Diller <ndiller@namesys.com>
Subject: Re: I request inclusion of reiser4 in the mainline kernel
Message-ID: <20050920114253.GL10845@suse.de>
References: <200509180934.50789.chriswhite@gentoo.org> <200509181321.23211.vda@ilport.com.ua> <20050918102658.GB22210@infradead.org> <b14e81f0050918102254146224@mail.gmail.com> <1127079524.8932.21.camel@localhost.localdomain> <432E4786.7010001@namesys.com> <432F8D1E.7060300@yahoo.com.au> <432FABFA.9010406@namesys.com> <1127200590.9436.15.camel@npiggin-nld.site> <432FC150.9020807@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <432FC150.9020807@namesys.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 20 2005, Hans Reiser wrote:
> >>The name for one.  There is no elevator algorithm anywhere in it.  There
> >>is a least block number first algorithm that was called an elevator, but
> >>    
> >>
> >
> >Well the terminology changed to "io scheduler" now, however the
> >residual "elevator" name found in places doesn't cause anyone
> >any problems and there isn't much reason to change it other than
> >the desire to break things.
> >  
> >
> Did you really say that?    I mean, come on, can't you at least manage a
> "well, it ought to get changed but I am busy with something more
> exciting to me".

Seeing as you are the one that is apparently bothered by the misnomer,
it follows that you would be the one submitting a patch for this. Not
that it would be accepted though, I don't see much point in renaming
functions and breaking drivers just because of a slightly bad name. The
io schedulers are all called foo-iosched.c, it's only the simple core
api that uses the 'elevator' description.

-- 
Jens Axboe

