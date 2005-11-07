Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965403AbVKGSRK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965403AbVKGSRK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 13:17:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965405AbVKGSRK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 13:17:10 -0500
Received: from THUNK.ORG ([69.25.196.29]:55731 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S965403AbVKGSRJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 13:17:09 -0500
Date: Mon, 7 Nov 2005 13:17:06 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: udev on 2.6.14 fails to create /dev/input/event2 on T40 Thinkpad
Message-ID: <20051107181706.GB8374@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>, Greg KH <greg@kroah.com>,
	linux-kernel@vger.kernel.org
References: <E1EYdMs-0001hI-3F@think.thunk.org> <20051106203421.GB2527@kroah.com> <20051107053648.GA7521@thunk.org> <20051107155243.GA14658@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051107155243.GA14658@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 07, 2005 at 07:52:43AM -0800, Greg KH wrote:
> > Yes, sorry, I got confused about which tree I had booting; this was
> > indeed a post-2.6.14 kernel (pulled using hg).
> 
> Ah good, scared me for a bit there :)
> 
> > Documentation/changes at the tip as of tonight still says use "udev
> > version 071", which is what I have installed.
> 
> Which should handle this just fine.  I suggest you file a bug against
> the debian package if this is not the case.

Ok, I'll gather more information but I was indeed using udev 0.71 from
Debian with a post 2.6.14 kernel, and it wasn't working for me.  I can
try again with stock udev from kernel.org, if you like, once I verify
that the Debian package hasn't changed anything critical which is
required for correct operation on Debian systems.

						- Ted
