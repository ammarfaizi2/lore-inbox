Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750774AbVLZW0W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750774AbVLZW0W (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Dec 2005 17:26:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750779AbVLZW0W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Dec 2005 17:26:22 -0500
Received: from pfepc.post.tele.dk ([195.41.46.237]:38525 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S1750774AbVLZW0W
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Dec 2005 17:26:22 -0500
Date: Mon, 26 Dec 2005 22:55:42 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Robin Holt <holt@sgi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Patch 1/1] Fix genksyms handling of DEFINE_PER_CPU(struct foo_s *, bar);
Message-ID: <20051226215542.GA31261@mars.ravnborg.org>
References: <20051221203601.GB20619@lnx-holt.americas.sgi.com> <20051221202356.GA31487@mars.ravnborg.org> <20051221220251.GA2924@lnx-holt.americas.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051221220251.GA2924@lnx-holt.americas.sgi.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 21, 2005 at 04:02:51PM -0600, Robin Holt wrote:
> On Wed, Dec 21, 2005 at 09:23:56PM +0100, Sam Ravnborg wrote:
> > On Wed, Dec 21, 2005 at 02:36:01PM -0600, Robin Holt wrote:
> > > This is a one-line change to parse.y.  It results in rebuilding the
> > > scripts/genksyms/*_shipped files.  Those are the next four patches.
> > Does this differ from the first patch-set you sent out?
> > I plan to apply these so they will be part of next round of kbuild
> > updates - which will take place during next merge window.
> 
> They are the same.  It took me four to finally get all the
> parts out and on the lkml.

Applied now. I created new _shipped files with the tools I have
installed.

bison (GNU Bison) 2.0
flex version 2.5.4
GNU gperf 3.0.1

This is (almost) a match of the same tools used for kconfig.

	Sam
