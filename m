Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261330AbSKNA6d>; Wed, 13 Nov 2002 19:58:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261238AbSKNA6d>; Wed, 13 Nov 2002 19:58:33 -0500
Received: from carisma.slowglass.com ([195.224.96.167]:59665 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S261330AbSKNA6c>; Wed, 13 Nov 2002 19:58:32 -0500
Date: Thu, 14 Nov 2002 01:05:22 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Christoph Hellwig <hch@infradead.org>, rusty@rustcorp.com.au,
       linux-kernel@vger.kernel.org
Subject: Re: module mess in -CURRENT
Message-ID: <20021114010522.A10402@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Linus Torvalds <torvalds@transmeta.com>, rusty@rustcorp.com.au,
	linux-kernel@vger.kernel.org
References: <20021114000206.A8245@infradead.org> <Pine.LNX.4.44.0211131655580.6810-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0211131655580.6810-100000@home.transmeta.com>; from torvalds@transmeta.com on Wed, Nov 13, 2002 at 04:59:35PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 13, 2002 at 04:59:35PM -0800, Linus Torvalds wrote:
> 
> On Thu, 14 Nov 2002, Christoph Hellwig wrote:
> > 
> > Linus, please backout that patch until we a) have modutils that support
> > both the new and old code and b) support at least such basic features
> > as parsing modules.conf and supporting parameters.
> 
> Quite frankly, at this time a backout means that the thing doesn't go in 
> _at_all_.

Probably.  Or just the non-intrusive parts.

> It came in before the feature freeze, but I decided that instead of having 
> a totally hectic time I woul dmerge stuff that I got before the freeze at 
> my own leisure, but backing it out now would be basically saying it's not 
> going into 2.6.x. And I think it's worth it.

I don't think it's a must have and absolutely don't think it's worth
breaking about everything at this stage.  Please tell me why rusty can't
send a large number of non-intrusive patches that do one thing at a
time just like everyone else?  
