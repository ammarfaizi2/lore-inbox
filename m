Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751462AbWFIRfv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751462AbWFIRfv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 13:35:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751456AbWFIRfv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 13:35:51 -0400
Received: from ns.suse.de ([195.135.220.2]:58818 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750795AbWFIRfu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 13:35:50 -0400
Date: Fri, 9 Jun 2006 10:32:41 -0700
From: Greg KH <greg@kroah.com>
To: Jeff Garzik <jeff@garzik.org>, Alex Tomas <alex@clusterfs.com>,
       Christoph Hellwig <hch@infradead.org>, linux-fsdevel@vger.kernel.org,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       Mingming Cao <cmm@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: [Ext2-devel] [RFC 0/13] extents and 48bit ext3
Message-ID: <20060609173241.GA32726@kroah.com>
References: <1149816055.4066.60.camel@dyn9047017069.beaverton.ibm.com> <20060609091327.GA3679@infradead.org> <m364jafu3h.fsf@bzzz.home.net> <44898476.80401@garzik.org> <m33beee6tc.fsf@bzzz.home.net> <4489874C.1020108@garzik.org> <m3y7w6cr7d.fsf@bzzz.home.net> <44899113.3070509@garzik.org> <20060609165643.GA5964@schatzie.adilger.int>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060609165643.GA5964@schatzie.adilger.int>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 09, 2006 at 10:56:43AM -0600, Andreas Dilger wrote:
> It's a lot better than e.g. the latest ubuntu which (apparently,
> I read) can't mount a kernel older than 2.6.15 because of udev (or
> sysfs?) changes.

If this is true, then it's only because the Ubuntu developers do not
want to support older kernel versions.  Other distros handle this just
fine (Gentoo and Debian for example).  This is not a kernel issue, but
rather a distro design issue.

Which is much different from the fact that I take a "ext3" partition
from my new distro and can't get to the data if I downgrade to an older
distro for whatever reason (or use an older rescue disk.)

Don't confuse distro design decisions from issues forced on an unknowing
user by the ext3 fs kernel developers.

thanks,

greg k-h
