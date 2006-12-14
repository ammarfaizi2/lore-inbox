Return-Path: <linux-kernel-owner+w=401wt.eu-S1751053AbWLNRjn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751053AbWLNRjn (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 12:39:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932889AbWLNRjm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 12:39:42 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:50795 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932888AbWLNRjm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 12:39:42 -0500
Date: Thu, 14 Dec 2006 17:38:27 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Chris Wedgwood <cw@f00f.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Jeff Garzik <jeff@garzik.org>,
       Greg KH <gregkh@suse.de>, Jonathan Corbet <corbet@lwn.net>,
       Andrew Morton <akpm@osdl.org>, Martin Bligh <mbligh@mbligh.org>,
       "Michael K. Edwards" <medwards.linux@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: GPL only modules [was Re: [GIT PATCH] more Driver core patches for 2.6.19]
Message-ID: <20061214173827.GC3452@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Chris Wedgwood <cw@f00f.org>, Linus Torvalds <torvalds@osdl.org>,
	Jeff Garzik <jeff@garzik.org>, Greg KH <gregkh@suse.de>,
	Jonathan Corbet <corbet@lwn.net>, Andrew Morton <akpm@osdl.org>,
	Martin Bligh <mbligh@mbligh.org>,
	"Michael K. Edwards" <medwards.linux@gmail.com>,
	linux-kernel@vger.kernel.org
References: <20061214003246.GA12162@suse.de> <22299.1166057009@lwn.net> <20061214005532.GA12790@suse.de> <Pine.LNX.4.64.0612131954530.5718@woody.osdl.org> <458171C1.3070400@garzik.org> <Pine.LNX.4.64.0612140855250.5718@woody.osdl.org> <20061214170841.GA11196@tuatara.stupidest.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061214170841.GA11196@tuatara.stupidest.org>
User-Agent: Mutt/1.4.2.2i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 14, 2006 at 09:08:41AM -0800, Chris Wedgwood wrote:
> On Thu, Dec 14, 2006 at 09:03:57AM -0800, Linus Torvalds wrote:
> 
> > I actually think the EXPORT_SYMBOL_GPL() thing is a good thing, if
> > done properly (and I think we use it fairly well).
> >
> > I think we _can_ do things where we give clear hints to people that
> > "we think this is such an internal Linux thing that you simply
> > cannot use this without being considered a derived work".
> 
> Then why not change the name to something more along those lines?

Yes, EXPORT_SYMBOL_INTERNAL would make a lot more sense.
