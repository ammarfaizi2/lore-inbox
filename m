Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129561AbRCAI6J>; Thu, 1 Mar 2001 03:58:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129562AbRCAI6B>; Thu, 1 Mar 2001 03:58:01 -0500
Received: from ns.caldera.de ([212.34.180.1]:5638 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S129552AbRCAI5v>;
	Thu, 1 Mar 2001 03:57:51 -0500
Date: Thu, 1 Mar 2001 09:18:03 +0100
From: Christoph Hellwig <hch@ns.caldera.de>
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Cc: Christoph Hellwig <hch@ns.caldera.de>,
        Alexander Zarochentcev <zam@namesys.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Hans Reiser <reiser@namesys.com>,
        reiserfs-dev@namesys.com
Subject: Re: [PATCH] reiserfs patch for linux-2.4.2
Message-ID: <20010301091803.A31546@caldera.de>
Mail-Followup-To: "Albert D. Cahalan" <acahalan@cs.uml.edu>,
	Christoph Hellwig <hch@ns.caldera.de>,
	Alexander Zarochentcev <zam@namesys.com>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Hans Reiser <reiser@namesys.com>, reiserfs-dev@namesys.com
In-Reply-To: <20010228202733.A18073@caldera.de> <200103010316.f213G29209192@saturn.cs.uml.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i
In-Reply-To: <200103010316.f213G29209192@saturn.cs.uml.edu>; from acahalan@cs.uml.edu on Wed, Feb 28, 2001 at 10:16:02PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 28, 2001 at 10:16:02PM -0500, Albert D. Cahalan wrote:
> Christoph Hellwig writes:
> 
> > Urgg. limits.h is a userlevel header...
> > 
> > The attached patch will make similar atempts fail (but not this one as
> > there is also a limits.h in gcc's include dir).
> 
> There are very few files needed from gcc's include dir. Linux ought to
> be able to survive without them. Linux is already gcc-specific anyway.

I think we want stdarg.h from gcc...

	Christoph

-- 
Of course it doesn't work. We've performed a software upgrade.
