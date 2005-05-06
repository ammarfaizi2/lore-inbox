Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261179AbVEFInQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261179AbVEFInQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 May 2005 04:43:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261181AbVEFInQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 May 2005 04:43:16 -0400
Received: from hera.cwi.nl ([192.16.191.8]:12268 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S261179AbVEFInJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 May 2005 04:43:09 -0400
Date: Fri, 6 May 2005 10:43:00 +0200
From: Andries Brouwer <Andries.Brouwer@cwi.nl>
To: Chris Wright <chrisw@osdl.org>
Cc: Andries Brouwer <aebr@win.tue.nl>, "Randy.Dunlap" <rddunlap@osdl.org>,
       Greg KH <greg@kroah.com>, joecool1029@gmail.com,
       linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: Empty partition nodes not created (was device node issues with recent mm's and udev)
Message-ID: <20050506084259.GB25418@apps.cwi.nl>
References: <d4757e6005050219514ece0c0a@mail.gmail.com> <20050503031421.GA528@kroah.com> <20050502202620.04467bbd.rddunlap@osdl.org> <20050506080056.GD4604@pclin040.win.tue.nl> <20050506081009.GX23013@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050506081009.GX23013@shell0.pdx.osdl.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 06, 2005 at 01:10:09AM -0700, Chris Wright wrote:
> * Andries Brouwer (aebr@win.tue.nl) wrote:
> > No, there is no problem but an intentional change in behaviour in -mm
> > and now also in 2.6.11.8.
> 
> I think this should be backed out of -stable.

I was surprised to find it in, after I had written

============
Date: Sat, 30 Apr 2005 21:58:07 +0200

For the time being, although I do not object to the patch,
obviously, since it is my own, I cannot see any reason to
add it to the "fixed" release.
============

but maybe including it was done by mistake?
It wasn't mentioned, I think, in the changelog.

There was a report that it fixed an oops,
but the report is unconfirmed and ununderstood.

Should it be backed out of 2.6.11.8? Possibly - but if it will be
part of 2.6.12 or 2.6.13 then I would be inclined to leave it.

Andrew asks whether it should be removed from -mm.
Will first read all my mail and then reply to that letter.
Maybe you should coordinate with Andrew and take the same decision.

Andries
