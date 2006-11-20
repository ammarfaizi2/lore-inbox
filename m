Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933800AbWKTAMf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933800AbWKTAMf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Nov 2006 19:12:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933802AbWKTAMe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Nov 2006 19:12:34 -0500
Received: from ns2.suse.de ([195.135.220.15]:50138 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S933800AbWKTAMd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Nov 2006 19:12:33 -0500
Date: Sun, 19 Nov 2006 16:12:12 -0800
From: Greg KH <gregkh@suse.de>
To: Jiri Slaby <jirislaby@gmail.com>
Cc: Paul Sokolovsky <pmiscml@gmail.com>, linux-kernel@vger.kernel.org,
       Adrian Bunk <bunk@stusta.de>, kernel-discuss@handhelds.org
Subject: Re: Where did find_bus() go in 2.6.18?
Message-ID: <20061120001212.GA28427@suse.de>
References: <1154868495.20061120003437@gmail.com> <4560ECAF.1030901@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4560ECAF.1030901@gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 20, 2006 at 12:45:51AM +0100, Jiri Slaby wrote:
> Paul Sokolovsky wrote:
> >   But alas, the commit message is not as good as some others are, and
> > doesn't mention what should be used instead. So, if find_bus() is
> > "unused", what should be used instead?
> 
> You should probably mention what for?

Exactly.  It was removed because no one was using it, and I couldn't
think of a reason why it would be needed.

Also, any reason why your drivers aren't in the mainline kernel yet?  It
would have kept something like this from happening a while ago.  And, it
will also help out with the recent driver core changes that are being
planned and are starting to show up in the -mm tree.  If your stuff is
in the kernel, then I'll do the work for you, otherwise, you all are on
your own :(

thanks,

greg k-h
