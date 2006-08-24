Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030263AbWHXDnL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030263AbWHXDnL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 23:43:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030264AbWHXDnL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 23:43:11 -0400
Received: from mx1.suse.de ([195.135.220.2]:57774 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1030263AbWHXDnJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 23:43:09 -0400
Date: Wed, 23 Aug 2006 20:42:46 -0700
From: Greg KH <gregkh@suse.de>
To: Dax Kelson <dax@gurulabs.com>
Cc: James Bottomley <James.Bottomley@SteelEye.com>,
       Andrew Morton <akpm@osdl.org>, Theodore Bullock <tbullock@nortel.com>,
       robm@fastmail.fm, brong@fastmail.fm, erich@areca.com.tw, greg@kroah.com,
       linux-kernel@vger.kernel.org
Subject: Re: Areca arcmsr kernel integration for 2.6.18?
Message-ID: <20060824034246.GA18826@suse.de>
References: <00a701c6b2b4$bb564b50$0e00cb0a@robm> <25E284CCA9C9A14B89515B116139A94D0C78805F@zrtphxm0.corp.nortel.com> <20060731200309.bd55c545.akpm@osdl.org> <1154530428.3683.0.camel@mulgrave.il.steeleye.com> <1156375551.4306.10.camel@mentorng.gurulabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1156375551.4306.10.camel@mentorng.gurulabs.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 23, 2006 at 05:25:51PM -0600, Dax Kelson wrote:
> On Wed, 2006-08-02 at 10:53 -0400, James Bottomley wrote:
> > On Mon, 2006-07-31 at 20:03 -0700, Andrew Morton wrote:
> > > > Ok, so how does this go from here into the mainline kernel?
> > > 
> > > James has moved the driver into the scsi-misc tree, so I assume he has
> > > 2.6.19 plans for it.
> > 
> > Yes, that's the usual path for scsi-misc.
> > 
> > James
> 
> It would be great if the arcmsr driver could be included in 2.6.18 so it
> can make into all the new distro releases that will be happening the
> last 3-4 months of the year.

What distros would that be?  And how do you know that they are going to
freeze their kernels at 2.6.18?

> It is completely self contained and it isn't changing any existing code
> (ergo it can't break anything) so I believe there is quite a bit of
> precedence for "late" inclusion in 2.6.18?

Then it can easily be bundled as a "kernel module package" for those
same distros if this is the case :)

thanks,

greg k-h
