Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262549AbUBYA2e (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 19:28:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262550AbUBYA2e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 19:28:34 -0500
Received: from mail.zmailer.org ([62.78.96.67]:57766 "EHLO mail.zmailer.org")
	by vger.kernel.org with ESMTP id S262549AbUBYA20 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 19:28:26 -0500
Date: Wed, 25 Feb 2004 02:28:19 +0200
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: Rik van Riel <riel@redhat.com>
Cc: Greg KH <greg@kroah.com>, Christoph Hellwig <hch@infradead.org>,
       "Woodruff, Robert J" <woody@co.intel.com>, linux-kernel@vger.kernel.org,
       "Hefty, Sean" <sean.hefty@intel.com>,
       "Coffman, Jerrie L" <jerrie.l.coffman@intel.com>,
       "Davis, Arlin R" <arlin.r.davis@intel.com>,
       marcelo.tosatti@cyclades.com, torvalds@osdl.org
Subject: Re: PATCH - InfiniBand Access Layer (IBAL)
Message-ID: <20040225002819.GP1751@mea-ext.zmailer.org>
References: <20040224195745.GA777@kroah.com> <Pine.LNX.4.44.0402241728460.21522-100000@chimarrao.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0402241728460.21522-100000@chimarrao.boston.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 24, 2004 at 05:29:16PM -0500, Rik van Riel wrote:
> On Tue, 24 Feb 2004, Greg KH wrote:
> > On Tue, Feb 24, 2004 at 07:50:18PM +0000, Christoph Hellwig wrote:
> > > I don't understand why anyone is wasting time on this.  Without available
> > > hardware drivers this huge midlayer is completely useless.
> > You mean this whole huge chunk of code doesn't have any hardware
> > drivers?  What good is it then?
> 
> Beats me. I hope we can just bury this infiniband stuff
> before we waste any more time on it.
> 
> I really can't see any reason why we would want to have
> this.

Maybe you don't, but some do.  Uses are rare, of course, but:
  http://www.apple.com/education/science/profiles/vatech/

People building "cheap supercomputers" will be going that way
most definitely.  Slowest version is 2.5 Gbit/s, and most
common one appears to be running 4x that.


Another thing (for which I would have use at hand right away, actually)
is to have fully functional Fibre Channel subsystem in Linux along
with drivers to modern cards e.g. JNI's.  (2 Gbit/s FC)

Plugging tens of terabytes of disks on a box is somewhat challenging
without resorting to that technology...

I just don't have luxury of having a year or two to spend on
development of necessary things, I need to choose systems with
the support readily in place so I can load in my applications,
and start using them.  :-/


/Matti Aarnio
