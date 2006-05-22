Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965180AbWEYO7x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965180AbWEYO7x (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 10:59:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965185AbWEYO7w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 10:59:52 -0400
Received: from fmr18.intel.com ([134.134.136.17]:33409 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S965180AbWEYO7w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 10:59:52 -0400
Date: Mon, 22 May 2006 14:34:04 -0700
From: mark gross <mgross@linux.intel.com>
To: Doug Thompson <norsk5@yahoo.com>
Cc: gtm.kramer@inter.nl.net, Andrew Morton <akpm@osdl.org>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/6]  EDAC Patch Set
Message-ID: <20060522213404.GA9881@linux.intel.com>
Reply-To: mgross@linux.intel.com
References: <1148494676.3282.8.camel@paragon.slim> <20060524185512.99258.qmail@web50105.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060524185512.99258.qmail@web50105.mail.yahoo.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 24, 2006 at 11:55:12AM -0700, Doug Thompson wrote:
> 
> 
> --- Jurgen Kramer <gtm.kramer@inter.nl.net> wrote:
> > 
> > Will this patchset fix/suppress the "Non-Fatal Error PCI Express B"
> > messages I see with the E7525 edac?
> 
> No not yet. These patches are part of the set we gathered in the queue after EDAC
> was put into the kernel as a result of various other feedback.  The Non-Fatal noise
> has been placed in the queue of work to do. Dave Peterson, who was co-maintainer of
> EDAC, has moved on, so I have picking up the TODO slack and flushing these patches
> out the door so I can start with a somewhat cleaner slate.
> 
> The good news is I have found a maintainer for the E7525 MC driver (I don't have
> access to a mobo with that chipset, so I have a problem in verifying any mods I do
> work) who has agreed to work with that driver. Thanks to mark gross for taking that
> on. He and I have discussed this noise issue.
> 

I have a couple of platforms that reproduce the non-fatal pci express noise.

As I mentioned to Doug, I will dig into this issue after OLS.   However; if
anyone has any ideas to share with me on it I'll take any advice I can get.  I
first would like to get a good root cause on why these things are coming from
the PCI code atfer loading the edac_e752x driver. 

--mgross

> doug thompson
> 
> > 
> > I am running 2.6.16 (or more specific FC5 2.6.16-1.2111) with seems to
> > already include this version:
> > 
> > MC: drivers/edac/edac_mc.c version edac_mc  Ver: 2.0.0 May  4 2006
> > 
> > This version still floods my syslog with "Non-Fatal Error...." messages.
> > 
> > Jurgen
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
