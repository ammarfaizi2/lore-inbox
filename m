Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932451AbWHHANN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932451AbWHHANN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 20:13:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932452AbWHHANN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 20:13:13 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:48552 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932451AbWHHANN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 20:13:13 -0400
Date: Tue, 8 Aug 2006 02:12:55 +0200
From: Pavel Machek <pavel@suse.cz>
To: Zachary Amsden <zach@vmware.com>
Cc: Rik van Riel <riel@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, greg@kroah.com,
       Andrew Morton <akpm@osdl.org>, Christoph Hellwig <hch@infradead.org>,
       Rusty Russell <rusty@rustcorp.com.au>, Jack Lo <jlo@vmware.com>
Subject: Re: A proposal - binary
Message-ID: <20060808001255.GQ2759@elf.ucw.cz>
References: <44D1CC7D.4010600@vmware.com> <44D217A7.9020608@redhat.com> <44D24236.305@vmware.com> <20060805104507.GA4506@ucw.cz> <44D67109.6020605@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44D67109.6020605@vmware.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 2006-08-06 15:45:29, Zachary Amsden wrote:
> Pavel Machek wrote:
> >...it should be very easy to opensource simple 'something' layer. If
> >it is so complex it is 'hard' to opensource, it is missdesigned,
> >anyway... so fix the design.
> >  
> 
> It's not a design issue - it's a legal issue at this point, and one that 
> I'm not qualified to come up with a good answer for.  The biggest 
> technical issue I think for open sourcing the VMI, is that it is not 
> part of the kernel, but stand alone firmware with a rather bizarre build 
> environment, so the code alone is not sufficient to allow it to be open 
> sourced, but this is not a hard problem to solve.

Well, I guess we'd like VMI to be buildable in normal kernel build
tools ... and at that point, open sourcing it should be _really_ easy.

And we'd prefer legal decisions not to influence technical ones. Maybe
we will decide to use binary interface after all, but seeing GPLed,
easily-buildable interface, first, means we can look at both solutions
and decide which one is better.
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
