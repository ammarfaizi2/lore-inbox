Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262522AbVD3GIx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262522AbVD3GIx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Apr 2005 02:08:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262524AbVD3GIx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Apr 2005 02:08:53 -0400
Received: from pfepa.post.tele.dk ([195.41.46.235]:25700 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S262522AbVD3GIv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Apr 2005 02:08:51 -0400
Date: Sat, 30 Apr 2005 08:09:23 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: aq <aquynh@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fs/Kconfig: more consistent configuration of XFS
Message-ID: <20050430060923.GB3977@mars.ravnborg.org>
References: <9cde8bff050428005528ecf692@mail.gmail.com> <20050428080914.GA10799@infradead.org> <9cde8bff0504280138b979c08@mail.gmail.com> <20050428083922.GA11542@infradead.org> <9cde8bff05042802213ec650e0@mail.gmail.com> <20050429212835.GD8699@mars.ravnborg.org> <9cde8bff05042919025d077eb1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9cde8bff05042919025d077eb1@mail.gmail.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 30, 2005 at 11:02:27AM +0900, aq wrote:
> 
> > 
> > About your modifications:
> > 
> > Skipping the menu part is OK.
> > While you are modifying Kconfig in xfs/ put a
> > 
> > if XFS_FS
> > ...
> > endif
> > 
> > around all config options expcept the one defining the XFS_FS option.
> > This will fix menu identing.
> 
> Thanks for pointing this out. But the patch I posted is fair enough.
> It just move one menu item around, and change nothing else. Are you
> happy with it?
If indention is OK for all menu entries in XFS - yes. Otherwise not.
I haven't tested it.

	Sam
