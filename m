Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261241AbVAGAYs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261241AbVAGAYs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 19:24:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261190AbVAGAYc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 19:24:32 -0500
Received: from [213.146.154.40] ([213.146.154.40]:19377 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261174AbVAGAXs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 19:23:48 -0500
Date: Fri, 7 Jan 2005 00:23:35 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Greg KH <greg@kroah.com>
Cc: Andrew Morton <akpm@osdl.org>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>, paulmck@us.ibm.com,
       arjan@infradead.org, linux-kernel@vger.kernel.org, jtk@us.ibm.com,
       wtaber@us.ibm.com, pbadari@us.ibm.com, markv@us.ibm.com,
       greghk@us.ibm.com, Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] add feature-removal-schedule.txt documentation
Message-ID: <20050107002335.GA28865@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>,
	Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
	paulmck@us.ibm.com, arjan@infradead.org,
	linux-kernel@vger.kernel.org, jtk@us.ibm.com, wtaber@us.ibm.com,
	pbadari@us.ibm.com, markv@us.ibm.com, greghk@us.ibm.com,
	Linus Torvalds <torvalds@osdl.org>
References: <20050106190538.GB1618@us.ibm.com> <1105039259.4468.9.camel@laptopd505.fenrus.org> <20050106201531.GJ1292@us.ibm.com> <20050106203258.GN26051@parcelfarce.linux.theplanet.co.uk> <20050106210408.GM1292@us.ibm.com> <20050106212417.GQ26051@parcelfarce.linux.theplanet.co.uk> <20050106152621.395f935e.akpm@osdl.org> <20050106235633.GA10110@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050106235633.GA10110@kroah.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 06, 2005 at 03:56:34PM -0800, Greg KH wrote:
> On Thu, Jan 06, 2005 at 03:26:21PM -0800, Andrew Morton wrote:
> > Which begs the question "how do we ever get rid of these things when we
> > have no projected date for Linux-2.8"?
> > 
> > I'd propose:
> > 
> > a) Create Documentation/feature-removal-schedule.txt which describes
> >    things which are going away, when, why, who is involved, etc.
> 
> Ok, I'll bite, here's a patch that does just that.  Look good?

another item:


What:	unused exports that don't make sense as general APIs
When:	as soon as noticed
Files:	all
Why:	Unused functions bloat the kernel and wrong exported functions
	will make external driver authors write code that's buggy and
	unmaintainable.
Who:	Christoph Hellwig <hch@lst.de> & others.
