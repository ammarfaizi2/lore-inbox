Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964776AbVKGFhG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964776AbVKGFhG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 00:37:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964777AbVKGFhF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 00:37:05 -0500
Received: from THUNK.ORG ([69.25.196.29]:53414 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S964776AbVKGFhE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 00:37:04 -0500
Date: Mon, 7 Nov 2005 00:36:49 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: udev on 2.6.14 fails to create /dev/input/event2 on T40 Thinkpad
Message-ID: <20051107053648.GA7521@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>, Greg KH <greg@kroah.com>,
	linux-kernel@vger.kernel.org
References: <E1EYdMs-0001hI-3F@think.thunk.org> <20051106203421.GB2527@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051106203421.GB2527@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 06, 2005 at 12:34:21PM -0800, Greg KH wrote:
> On Sun, Nov 06, 2005 at 12:47:02AM -0500, Theodore Ts'o wrote:
> > +P: /class/input/input3/event3
> 
> No, this shows a post-2.6.14 kernel, not 2.6.14 as what is located on
> kernel.org, right?  I'm guessing 2.6.14-git1?  Or is this a distro based
> kernel?
> 
> If so, you need to upgrade udev, as the Documentation says to :)
> 
> If not, and this is 2.6.14, something is very wrong...

Yes, sorry, I got confused about which tree I had booting; this was
indeed a post-2.6.14 kernel (pulled using hg).

Documentation/changes at the tip as of tonight still says use "udev
version 071", which is what I have installed.  I note that the latest
version on kernel.org is udev 072 --- is that what is going to be
required for 2.6.15?  If so, better warn folks at distro's like Debian
unstable.  If not, what do I need to change so I can easily test post
2.6.14 kernels --- and where was it documented that I needed a newer
version of udev?

						- Ted

