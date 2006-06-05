Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1750830AbWFEJQR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750830AbWFEJQR (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 05:16:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750837AbWFEJQR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 05:16:17 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:36077 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750830AbWFEJQQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 05:16:16 -0400
Subject: Re: merging new drivers (was Re: 2.6.18 -mm merge plans)
From: Arjan van de Ven <arjan@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Christoph Hellwig <hch@infradead.org>, jeff@garzik.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20060605021054.4d5428da.akpm@osdl.org>
References: <20060604135011.decdc7c9.akpm@osdl.org>
	 <20060605013223.GD17361@havoc.gtf.org>
	 <20060604184711.0a328d18.akpm@osdl.org>
	 <20060605085918.GB26766@infradead.org>
	 <20060605021054.4d5428da.akpm@osdl.org>
Content-Type: text/plain
Date: Mon, 05 Jun 2006 11:16:09 +0200
Message-Id: <1149498969.3111.35.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-06-05 at 02:10 -0700, Andrew Morton wrote:
> On Mon, 5 Jun 2006 09:59:18 +0100
> Christoph Hellwig <hch@infradead.org> wrote:
> 
> > On Sun, Jun 04, 2006 at 06:47:11PM -0700, Andrew Morton wrote:
> > > Yes, I agree.  As long as we reasonably think that a piece of code *will*
> > > become acceptable within a reasonable amount of time then going early is
> > > safe.
> > 
> > 
> > Definitly not the case for areca.  The only progress at all is where people
> > like Arjan, Randy or me did very intensive babysitting.  And it's still far
> > from beeing there.
> > 
> > And especially in scsi land I'm absolutely against putting in more substandard
> > drivers.  The subsystem is still badly plagued from lots of old drivers that
> > aren't up to any standards, and we need to decrease the maintaince load due
> > to odd drivers not increase it even further.
> 
> So..  How are we going to get the Areca controllers supported in Linux? 
> The code's been sitting in -mm for over a year and the vendor does have
> staff assigned to work on it.

the driver is improving for sure.

What seems to work well is when we make a work-to-do list, the vendor
then goes about and fixes most of that quite quickly. I think I'm
approaching the end of useful review input I can give (they fixed most
if not all the stuff I flagged before), it would be really nice if
Christoph or some other scsi person would do a review again and make a
list of "these should be fixed and then we can merge" (and a list of
"these can be fixed post merge" as well)


