Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932283AbVJQLr7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932283AbVJQLr7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 07:47:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932286AbVJQLr7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 07:47:59 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:8842 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932283AbVJQLr6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 07:47:58 -0400
Date: Mon, 17 Oct 2005 06:47:30 -0500
From: Robin Holt <holt@sgi.com>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: Robin Holt <holt@sgi.com>, Greg KH <greg@kroah.com>,
       ia64 list <linux-ia64@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       hch@infradead.org, jgarzik@pobox.com,
       William Lee Irwin III <wli@holomorphy.com>,
       Jack Steiner <steiner@americas.sgi.com>
Subject: Re: [Patch 2/3] Export get_one_pte_map.
Message-ID: <20051017114730.GC30898@lnx-holt.americas.sgi.com>
References: <20051014192111.GB14418@lnx-holt.americas.sgi.com> <20051014192225.GD14418@lnx-holt.americas.sgi.com> <20051014213038.GA7450@kroah.com> <20051017113131.GA30898@lnx-holt.americas.sgi.com> <1129549312.32658.32.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1129549312.32658.32.camel@localhost>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 17, 2005 at 01:41:52PM +0200, Dave Hansen wrote:
> On Mon, 2005-10-17 at 06:31 -0500, Robin Holt wrote:
> > On Fri, Oct 14, 2005 at 02:30:38PM -0700, Greg KH wrote:
> > > On Fri, Oct 14, 2005 at 02:22:25PM -0500, Robin Holt wrote:
> > > > +EXPORT_SYMBOL(get_one_pte_map);
> > > 
> > > EXPORT_SYMBOL_GPL() ?
> > 
> > Not sure why it would fall that way.  Looking at the directory,
> > I get:
> 
> Most of the VM stuff in those directories that you're referring to are
> old, crusty exports, from the days before _GPL.  We've left them to be
> polite, but if many of them were recreated today, they'd certainly be
> _GPL.

I got a little push from our internal incident tracking system for
this being a module.  _GPL it will be.

Thanks,
Robin
