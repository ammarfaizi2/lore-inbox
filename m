Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268101AbUHKQkr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268101AbUHKQkr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 12:40:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268097AbUHKQhM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 12:37:12 -0400
Received: from louise.pinerecords.com ([213.168.176.16]:8678 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id S268121AbUHKQfD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 12:35:03 -0400
Date: Wed, 11 Aug 2004 18:33:33 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: James Ketrenos <jketreno@linux.intel.com>,
       Christoph Hellwig <hch@infradead.org>, Pavel Machek <pavel@suse.cz>,
       Jeff Chua <jeffchua@silk.corp.fedex.com>, netdev@oss.sgi.com,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: ipw2100 wireless driver
Message-ID: <20040811163333.GE10100@louise.pinerecords.com>
References: <Pine.LNX.4.60.0407141947270.27995@boston.corp.fedex.com> <20040714115523.GC2269@elf.ucw.cz> <20040809201556.GB9677@louise.pinerecords.com> <Pine.LNX.4.61.0408101258130.1290@boston.corp.fedex.com> <20040810075558.A14154@infradead.org> <20040810101640.GF9034@atrey.karlin.mff.cuni.cz> <4119F203.1070009@linux.intel.com> <20040811114437.A27439@infradead.org> <411A478E.1080101@linux.intel.com> <20040811093043.522cc5a0@dell_ss3.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040811093043.522cc5a0@dell_ss3.pdx.osdl.net>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Aug-11 2004, Wed, 09:30 -0700
Stephen Hemminger <shemminger@osdl.org> wrote:

> > The driver supports (and defaults to) using firmware_class for loading the 
> > firmware.  The driver also supports a legacy loading approach for folks that 
> > have problems with using hotplug to load the firmware (which represents a fair 
> > number of users).
> When and if you submit it into mainline, please remove the legacy loading
> approach. Let's get to the cause of the problem and fix it, not bandaid
> around it.

Or better yet, let's not!

There are many people who don't want to mess around with hotplug just
to get a single driver to load.

-- 
Tomas Szepe <szepe@pinerecords.com>
