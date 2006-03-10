Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422668AbWCJBCl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422668AbWCJBCl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 20:02:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422663AbWCJBCl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 20:02:41 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:3210 "EHLO
	aria.kroah.org") by vger.kernel.org with ESMTP id S1422672AbWCJBCk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 20:02:40 -0500
Date: Thu, 9 Mar 2006 17:02:22 -0800
From: Greg KH <gregkh@suse.de>
To: "Bryan O'Sullivan" <bos@pathscale.com>
Cc: Greg KH <greg@kroah.com>, Roland Dreier <rdreier@cisco.com>,
       rolandd@cisco.com, akpm@osdl.org, davem@davemloft.net,
       linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [PATCH 8 of 20] ipath - sysfs support for core driver
Message-ID: <20060310010222.GB9945@suse.de>
References: <ef8042c934401522ed3f.1141922821@localhost.localdomain> <adapskvfbqe.fsf@cisco.com> <20060309234607.GA26898@kroah.com> <1141948777.10693.61.camel@serpentine.pathscale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1141948777.10693.61.camel@serpentine.pathscale.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 09, 2006 at 03:59:37PM -0800, Bryan O'Sullivan wrote:
> On Thu, 2006-03-09 at 15:46 -0800, Greg KH wrote:
> > On Thu, Mar 09, 2006 at 03:18:49PM -0800, Roland Dreier wrote:
> > 
> > Thanks for CC:ing me, but where were the originals of these posted?
> 
> My patch posting script screwed up.  Only Roland got them, even though
> the envelopes were all correct.
> 
> > >  > +static ssize_t show_atomic_stats(struct device_driver *dev, char *buf)
> > >  > +{
> > >  > +	memcpy(buf, &ipath_stats, sizeof(ipath_stats));
> > >  > +
> > >  > +	return sizeof(ipath_stats);
> > >  > +}
> > > 
> > > I think putting a whole binary struct in a sysfs attribute is
> > > considered a no-no.
> > 
> > That's an understatement, where is the large stick to thwap the author
> > of this code...
> 
> I'd like to understand why, though.  As I already explained, it's a
> smallish structure (< 1KB), and I can use the special binary sysfs
> attribute goo for it if you insist, but ... why?

I think I explained this in my prior post enough, right?  If not, please
let me know.

thanks,

greg k-h
