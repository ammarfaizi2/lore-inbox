Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932687AbWJLQpi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932687AbWJLQpi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 12:45:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932688AbWJLQpi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 12:45:38 -0400
Received: from colo.elevenwireless.com ([69.30.42.70]:12139 "EHLO
	smtp.elevennetworks.com") by vger.kernel.org with ESMTP
	id S932687AbWJLQpi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 12:45:38 -0400
Date: Thu, 12 Oct 2006 09:35:22 -0700
From: Greg KH <greg@kroah.com>
To: Theodore Tso <tytso@mit.edu>, Greg KH <gregkh@suse.de>,
       linux-kernel@vger.kernel.org, stable@kernel.org,
       Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Randy Dunlap <rdunlap@xenotime.net>, Dave Jones <davej@redhat.com>,
       Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk
Subject: Re: [stable] [patch 00/67] 2.6.18-stable review
Message-ID: <20061012163522.GE20868@kroah.com>
References: <20061011210310.GA16627@kroah.com> <20061012004244.GA9252@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061012004244.GA9252@thunk.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 11, 2006 at 08:42:44PM -0400, Theodore Tso wrote:
> On Wed, Oct 11, 2006 at 02:03:10PM -0700, Greg KH wrote:
> > And yes, we realize that this is a large number of patches, sorry...
> 
> I number of these patches were cleanups, such as removing code betewen
> #if 0, removing header files from being exported, etc.  Not bad
> things, but I wouldn't have thought it would have met the criteria for
> being added to -stable.  Are you intentionally relaxing the criteria?

The header file stuff was intentionally added, as it is good to have the
header files exported properly.  Those were a large number of these
patches.

If you have specific questions about any one patch, please let us know.
I didn't purposefully take any "cleanup" type patch that I know of, but
there was a lot here, so one might have slipped in...

thanks,

greg k-h
