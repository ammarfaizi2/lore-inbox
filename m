Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267164AbUIETka@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267164AbUIETka (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Sep 2004 15:40:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267165AbUIETka
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Sep 2004 15:40:30 -0400
Received: from pfepa.post.tele.dk ([195.41.46.235]:49952 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S267164AbUIETk2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Sep 2004 15:40:28 -0400
Date: Sun, 5 Sep 2004 21:43:23 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Ian Wienand <ianw@gelato.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] kbuild: Support LOCALVERSION
Message-ID: <20040905194323.GA16901@mars.ravnborg.org>
Mail-Followup-To: Ian Wienand <ianw@gelato.unsw.edu.au>,
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
	Christoph Hellwig <hch@lst.de>
References: <20040831192642.GA15855@mars.ravnborg.org> <20040901134341.GT6985@lug-owl.de> <20040901145646.GA7252@mars.ravnborg.org> <20040902104209.GA24544@cse.unsw.EDU.AU>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040902104209.GA24544@cse.unsw.EDU.AU>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 02, 2004 at 08:42:09PM +1000, Ian Wienand wrote:
> On Wed, Sep 01, 2004 at 04:56:47PM +0200, Sam Ravnborg wrote:
> > Ian addedconfig CONFIG_LOCALVERSION to a Kconfig file. I will
> > try to add it and see how it turns out. If Ian does not beat me..
> 
> Ok, here is my attempt.  I think it does everything everyone wants
> 
> * localversion* files are read first
> * config variable is appended last
> * LOCALVERSION from the command line overrides all of this
> * check is forced on build, since we can't really know when
>   the config or environment options change.
> 
> Thanks,
> 
> -i

applied - thanks (your mailer broke the patch but I fixed it up)

	Sam
