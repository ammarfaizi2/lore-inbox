Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269194AbUHZQea@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269194AbUHZQea (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 12:34:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269195AbUHZQdW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 12:33:22 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:24074 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S269132AbUHZQZm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 12:25:42 -0400
Date: Thu, 26 Aug 2004 17:25:28 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Christophe Saout <christophe@saout.de>
Cc: Christoph Hellwig <hch@lst.de>, Andrew Morton <akpm@osdl.org>,
       Hans Reiser <reiser@namesys.com>, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, flx@namesys.com, torvalds@osdl.org,
       reiserfs-list@namesys.com
Subject: Re: reiser4 plugins (was: silent semantic changes with reiser4)
Message-ID: <20040826172528.A21345@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Christophe Saout <christophe@saout.de>,
	Christoph Hellwig <hch@lst.de>, Andrew Morton <akpm@osdl.org>,
	Hans Reiser <reiser@namesys.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, flx@namesys.com, torvalds@osdl.org,
	reiserfs-list@namesys.com
References: <20040826130718.GB820@lst.de> <1093526273.11694.8.camel@leto.cs.pocnet.net> <20040826132439.GA1188@lst.de> <1093527307.11694.23.camel@leto.cs.pocnet.net> <20040826134034.GA1470@lst.de> <1093528683.11694.36.camel@leto.cs.pocnet.net> <20040826153748.GA3700@lst.de> <1093535334.5482.1.camel@leto.cs.pocnet.net> <20040826160601.GB4326@lst.de> <1093536859.5482.13.camel@leto.cs.pocnet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1093536859.5482.13.camel@leto.cs.pocnet.net>; from christophe@saout.de on Thu, Aug 26, 2004 at 06:14:19PM +0200
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 26, 2004 at 06:14:19PM +0200, Christophe Saout wrote:
> Ok, I see your point. aops. Sorry.
> Looking at the code this could be done. The wrappers that dispatch the
> operations are really small and call the plugin that is registered with
> the inode of the mapping. Instead it could have directly set the
> corresponding operations. Right. The wrappers are doing a few things
> before calling the plugin. That could be done the other way round too.
> But that's more of an implementation issue and could still be changed.

I agree that it's an implementation issue.  But it's also a good proof
for how Hans tries to ignore all the existing infrastructure for various
reasons.
