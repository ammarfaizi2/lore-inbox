Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261821AbVA3Wt5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261821AbVA3Wt5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jan 2005 17:49:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261822AbVA3Wt5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jan 2005 17:49:57 -0500
Received: from pfepb.post.tele.dk ([195.41.46.236]:57231 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S261821AbVA3Wtx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jan 2005 17:49:53 -0500
Date: Sun, 30 Jan 2005 23:51:39 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: kbuild: shorthand ym2y, ym2m etc
Message-ID: <20050130225139.GA21649@mars.ravnborg.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	linux-kernel@vger.kernel.org
References: <20050130193733.GA8984@mars.ravnborg.org> <20050130195230.GA871@infradead.org> <20050130223926.GG14816@mars.ravnborg.org> <20050130224452.G25000@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050130224452.G25000@flint.arm.linux.org.uk>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 30, 2005 at 10:44:52PM +0000, Russell King wrote:
 > This can be fixed by changing Kconfig to evaluate all known symbols to
> > either y,m,n - in contradiction to today where symbols that evaluate
> > to n is left empty.
> 
> Isn't that rather hard to achieve, unless all Kconfig files (including
> all architecture specific ones) are read?  Eg, CONFIG_PPC wouldn't
> exist on ARM.

Exactly - thats why I wrote "all known".
I do not see this as the solution that solve more than it breaks.
So I have not even tried it out.

	Sam
