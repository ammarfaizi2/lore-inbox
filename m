Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932486AbWASFnd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932486AbWASFnd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 00:43:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932545AbWASFnd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 00:43:33 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:22686
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S932486AbWASFnd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 00:43:33 -0500
Date: Wed, 18 Jan 2006 21:43:31 -0800
From: Greg KH <greg@kroah.com>
To: "Bryan O'Sullivan" <bos@pathscale.com>
Cc: "David S. Miller" <davem@davemloft.net>, akpm@osdl.org, rdreier@cisco.com,
       linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: RFC: ipath ioctls and their replacements
Message-ID: <20060119054331.GC21467@kroah.com>
References: <1137631411.4757.218.camel@serpentine.pathscale.com> <20060118.164839.74431051.davem@davemloft.net> <1137633256.4757.225.camel@serpentine.pathscale.com> <20060118.171716.04998471.davem@davemloft.net> <1137647821.25584.33.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1137647821.25584.33.camel@localhost.localdomain>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 18, 2006 at 09:17:01PM -0800, Bryan O'Sullivan wrote:
> On Wed, 2006-01-18 at 17:17 -0800, David S. Miller wrote:
> 
> > It's going to give you strict typing, and extensible attributes for
> > the configuration attributes you define.  So if you determine later
> > "oh we need to add this knob for changing X" you can do that without
> > breaking the existing interface.
> 
> Wow.  OK, that is not immediately obvious from reading the code.  The
> only modules in drivers/ that seem to use netlink are iscsi, connector,
> and w1.  It's more extensive in net/, I see.

The attribute stuff is pretty new, and I do not think any code in
drivers/ uses it yet.  But it is well documented in
include/net/netlink.h, have you looked at that?

> > Try not to get discouraged, give it a shot :)
> 
> It's not obvious what chunk of the the tree is a good example to follow.
> Just look what happened when I suggested to Greg that I use the Dell
> firmware loader as an example :-)

Well, it is good that you asked, far too many people do not.  And others
wonder why we are so insistant on everyone doing things properly in all
parts of the kernel, it's because of this reason.

Which reminds me to go back and look at that dell driver again...

thanks,

greg k-h
