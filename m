Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264292AbTHVRFt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Aug 2003 13:05:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264307AbTHVRFs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Aug 2003 13:05:48 -0400
Received: from verein.lst.de ([212.34.189.10]:26344 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S264292AbTHVRFf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Aug 2003 13:05:35 -0400
Date: Fri, 22 Aug 2003 19:05:23 +0200
From: Christoph Hellwig <hch@lst.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Christoph Hellwig <hch@lst.de>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fix the -test3 input config damages
Message-ID: <20030822170523.GA7819@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>,
	Linus Torvalds <torvalds@osdl.org>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20030822163800.GA7568@lst.de> <Pine.LNX.4.44.0308220947010.3258-100000@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0308220947010.3258-100000@home.osdl.org>
User-Agent: Mutt/1.3.28i
X-Spam-Score: -5 () EMAIL_ATTRIBUTION,IN_REP_TO,QUOTED_EMAIL_TEXT,REFERENCES,REPLY_WITH_QUOTES,USER_AGENT_MUTT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 22, 2003 at 09:50:05AM -0700, Linus Torvalds wrote:
> 
> On Fri, 22 Aug 2003, Christoph Hellwig wrote:
> >
> > There's really no point in forcing in support for all kinds of
> > optional input devices unless CONFIG_EMBEDDED.
> 
> I disagree. We've had too many totally unnecessary bug-reports from 
> people, and it's just not worth it not having the keyboard and mouse 
> controller driver.

That's because we didn't have the "select INPUT if VT" yet..

Anyone, can we at least get a different option for this thingy then?
CONFIG_EMBEDEDDED is even more wrong in this context than in the
old one.

What about two new options to replace the old CONFIG_EMBEDDED?

 - CONFIG_AUNT_TILLIE - for this kind of shoot yourself in the foot
   protection

and

  - CONFIG_NONSTD_ABI - for the original sense of a kernel so limited
    that parts of the usual userland ABI may disappear

