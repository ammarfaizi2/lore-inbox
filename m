Return-Path: <linux-kernel-owner+w=401wt.eu-S1751926AbWLNBIJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751926AbWLNBIJ (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 20:08:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751927AbWLNBII
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 20:08:08 -0500
Received: from vena.lwn.net ([206.168.112.25]:54584 "EHLO vena.lwn.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751926AbWLNBIH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 20:08:07 -0500
X-Greylist: delayed 1478 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Dec 2006 20:08:07 EST
To: Greg KH <gregkh@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, Martin Bligh <mbligh@mbligh.org>,
       "Michael K. Edwards" <medwards.linux@gmail.com>,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: GPL only modules [was Re: [GIT PATCH] more Driver core patches for 2.6.19] 
From: corbet@lwn.net (Jonathan Corbet)
In-reply-to: Your message of "Wed, 13 Dec 2006 16:32:46 PST."
             <20061214003246.GA12162@suse.de> 
Date: Wed, 13 Dec 2006 17:43:29 -0700
Message-ID: <22299.1166057009@lwn.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg's patch:

> +			printk(KERN_WARNING "%s: This module will not be able "
> +				"to be loaded after January 1, 2008 due to its "
> +				"license.\n", mod->name);

If you're going to go ahead with this, shouldn't the message say that
the module will not be loadable into *kernels released* after January 1,
2008?  I bet a lot of people would read the above to say that their
system will just drop dead of a New Year's hangover, and they'll freak.
I wouldn't want to be the one getting all the email at that point...

jon

