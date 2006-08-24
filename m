Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751628AbWHXRAV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751628AbWHXRAV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 13:00:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751634AbWHXRAV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 13:00:21 -0400
Received: from mail.suse.de ([195.135.220.2]:19406 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751628AbWHXRAU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 13:00:20 -0400
Date: Thu, 24 Aug 2006 09:59:24 -0700
From: Greg KH <greg@kroah.com>
To: Theodore Bullock <tbullock@nortel.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Arjan van de Ven <arjan@infradead.org>, Dax Kelson <dax@gurulabs.com>,
       Greg KH <gregkh@suse.de>,
       James Bottomley <James.Bottomley@SteelEye.com>,
       Andrew Morton <akpm@osdl.org>, robm@fastmail.fm, brong@fastmail.fm,
       erich@areca.com.tw, linux-kernel@vger.kernel.org
Subject: Re: Areca arcmsr kernel integration for 2.6.18?
Message-ID: <20060824165924.GA13807@kroah.com>
References: <1156419687.3007.98.camel@localhost.localdomain> <25E284CCA9C9A14B89515B116139A94D0D353411@zrtphxm0.corp.nortel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <25E284CCA9C9A14B89515B116139A94D0D353411@zrtphxm0.corp.nortel.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 24, 2006 at 12:21:01PM -0400, Theodore Bullock wrote:
> I posted a feature enchancement request to the Novell bugzilla for the
> 10.2 openSUSE release (currently scheduled for 2.6.18 AFAIK, depends on
> upstream timelines), and the response from Greg was this:
> 
> "If this driver is in the mainline kernel, it will show up in our
> releases, and that's the only way we can accept it at this point in
> time.  We will not backport it to an older kernel version."

Yes, that was my suse engineer side talking.  It has _nothing_ to do
with my community work, please don't mix the two.

> If the driver goes into 2.6.19 this means 8 to 12 months of time before
> our workstations will be supported enough by Novell to start a more
> widespread deployment in the company out of the test lab.  We would
> prefer this driver to be made available earlier, if only to make
> installation more feasible and kernel upgrades possible.

No, you can _always_ have Novell create a stand-alone kernel module
package if you want them to (and can convince them to, you need to speak
with some project managers to get that to happen...)  You can also do
this on your own, as it is very simple to do and support over time.

Even if this driver went into 2.6.18, you would _still_ have the same
situation from Novell, so I do not see how you bring this up has any
relevance here.

And you don't even know what the next SuSE release will base their
kernel on yet, as it hasn't been decided :)

thanks,

greg k-h
