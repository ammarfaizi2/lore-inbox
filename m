Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030277AbWBHW5s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030277AbWBHW5s (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 17:57:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030305AbWBHW5s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 17:57:48 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:31891
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S1030297AbWBHW5r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 17:57:47 -0500
Date: Wed, 8 Feb 2006 14:57:33 -0800
From: Greg KH <greg@kroah.com>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Greg KH <gregkh@suse.de>, linux-kernel@vger.kernel.org,
       dipankar@in.ibm.com, paul.mckenney@us.ibm.com,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: [patch 01/03] add EXPORT_SYMBOL_GPL_FUTURE()
Message-ID: <20060208225733.GA28826@kroah.com>
References: <20060208184816.GA17016@kroah.com> <20060208184922.GB17016@kroah.com> <20060208194926.GA8671@mars.ravnborg.org> <20060208201645.GA9497@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060208201645.GA9497@mars.ravnborg.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 08, 2006 at 09:16:45PM +0100, Sam Ravnborg wrote:
> On Wed, Feb 08, 2006 at 08:49:26PM +0100, Sam Ravnborg wrote:
> > On Wed, Feb 08, 2006 at 10:49:22AM -0800, Greg KH wrote:
> > > This patch adds the ability to mark symbols that will be changed in the
> > > future, so that non-GPL usage of them is flagged by the kernel and
> > > printed out to the system log.
> > > 
> > > Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
> > The patch duplicate too much code to my taste at least.
> > May I suggest to consolidate a little in module.c before applying the
> > GPL_FUTURE stuff.
> > 
> > Have you considered: EXPORT_GPL_SOON()?

Well, as I'm proposing that the USB symbols be converted in 2 years,
that's not exactly "SOON" :)

> Better version below...

Very nice, I've added this to my tree.  I had originally tried to do
something like this, but your version is very nice compared to my bad
hack.

thanks,

greg k-h
