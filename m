Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263846AbTKSAYz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Nov 2003 19:24:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263848AbTKSAYy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Nov 2003 19:24:54 -0500
Received: from host213-160-108-25.dsl.vispa.com ([213.160.108.25]:61347 "HELO
	cenedra.office") by vger.kernel.org with SMTP id S263846AbTKSAYx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Nov 2003 19:24:53 -0500
From: Andrew Walrond <andrew@walrond.org>
To: Larry McVoy <lm@bitmover.com>, Ben Collins <bcollins@debian.org>
Subject: Re: kernel.bkbits.net off the air
Date: Wed, 19 Nov 2003 00:24:51 +0000
User-Agent: KMail/1.5.4
Cc: Larry McVoy <lm@bitmover.com>, Sven Dowideit <svenud@ozemail.com.au>,
       linux-kernel@vger.kernel.org
References: <fa.eto0cvm.1v20528@ifi.uio.no> <20031118183058.GS476@phunnypharm.org> <20031118184200.GA13966@work.bitmover.com>
In-Reply-To: <20031118184200.GA13966@work.bitmover.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311190024.51548.andrew@walrond.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm likely to get a slap for this one, but....

On Tuesday 18 Nov 2003 6:42 pm, Larry McVoy wrote:
>
> I'm curious as to why you would think this is better than the CVS gateway.
> The CVS gateway is actually a really nice thing.  The whiners think we
> have somehow hamstrung the data in the gateway but that's only because
> they haven't looked at the data, if they had done a careful comparison
> then they'd know it's all in there.

Since you've already done all the work for bk2cvs, why not add the 
functionality to bkd which would allow a simple client to do

	lobobk cvsclone
and
	lobobk cvspull

Ie be able to clone and update a local cvs repo from bkd? This would have the 
added advantage that users (kernel testers) could get any tagged versions 
from their local repo using cvs, rather than requiring diff trasmission from 
bkd to convert to another version. The client would be very simple too.

Obviously the local cvs repo would be read-only, and only useful for people to 
fetch sources. Bitkeeper would be required for development work. It would 
make the perfect mirroring tool aswell.

And when you've finished that, I'd like a moon rocket please. GPL, of 
course ;)

Andrew Walrond

