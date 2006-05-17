Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750857AbWEQWnh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750857AbWEQWnh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 18:43:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750859AbWEQWnh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 18:43:37 -0400
Received: from cantor2.suse.de ([195.135.220.15]:56805 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750826AbWEQWng (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 18:43:36 -0400
Date: Wed, 17 May 2006 15:41:24 -0700
From: Greg KH <greg@kroah.com>
To: Chris Wright <chrisw@sous-sol.org>
Cc: Linus Torvalds <torvalds@osdl.org>, "Theodore Ts'o" <tytso@mit.edu>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Justin Forbes <jmforbes@linuxtx.org>, linux-kernel@vger.kernel.org,
       Randy Dunlap <rdunlap@xenotime.net>, Dave Jones <davej@redhat.com>,
       Chuck Wolber <chuckw@quantumlinux.com>, stable@kernel.org,
       alan@lxorguk.ukuu.org.uk
Subject: Re: [stable] Re: [PATCH 00/22] -stable review
Message-ID: <20060517224124.GA23967@kroah.com>
References: <20060517221312.227391000@sous-sol.org> <Pine.LNX.4.64.0605171522050.10823@g5.osdl.org> <20060517223601.GI2697@moss.sous-sol.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060517223601.GI2697@moss.sous-sol.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 17, 2006 at 03:36:01PM -0700, Chris Wright wrote:
> * Linus Torvalds (torvalds@osdl.org) wrote:
> > 
> > 
> > On Wed, 17 May 2006, Chris Wright wrote:
> > >
> > > This is the start of the stable review cycle for the 2.6.16.17 release.
> > > There are 22 patches in this series, all will be posted as a response to
> > > this one.
> > 
> > I notice that none of the patches have authorship information.
> > 
> > Has that always been true and I just never noticed before?
> 
> It has always been that way with my script, I think Greg's as well.  Of
> course, it's in the patch, and goes into git with proper authorship.

The original versions of the patches do have the proper authorship
information, it's just that quilt strips it off when generating emails
like this.

When applying them to the git tree, everything comes out properly and
they get the correct authorship information.  And the git tools know to
properly create the emails with the right From: lines, maybe I should
play around with quilt to add that to it too...

thanks,

greg k-h
