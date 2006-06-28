Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751177AbWF1UDV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751177AbWF1UDV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 16:03:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751183AbWF1UDV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 16:03:21 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:38298 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751177AbWF1UDU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 16:03:20 -0400
Date: Wed, 28 Jun 2006 22:03:06 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Brad Campbell <brad@wasp.net.au>
Cc: Nigel Cunningham <ncunningham@linuxmail.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       suspend2-devel@lists.suspend2.net
Subject: Re: [Suspend2-devel] Re: Suspend2 - Request for review & inclusion in	-mm
Message-ID: <20060628200306.GE18039@elf.ucw.cz>
References: <200606270147.16501.ncunningham@linuxmail.org> <20060627133321.GB3019@elf.ucw.cz> <44A14D3D.8060003@wasp.net.au> <20060627190323.GA28863@elf.ucw.cz> <44A21B0F.20304@wasp.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44A21B0F.20304@wasp.net.au>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> When I installed ubuntu 6.06 on my shiny new laptop, I pressed the 
> hibernate button. The screen went black, the hard disk light locked on and 
> it just sat there. I thought to myself "oh dear, it's locked up" so I 
> pulled the battery out and restarted the machine. (Ubuntu uses the 
> in-kernel swsusp). It turns out the machine was actually hibernating. Who 
> would have known? I told me nothing and behaved *exactly* like a machine 
> hard-locked. So on this one box, the in-kernel suspend actually works, for 
> certain definitions of works.

Increase console loglevel if you want to see the messages, this is
FAQ.

> And of course on my other laptop it just does weird things. I could 
> probably help debug it if I had the time or inclination, but seriously.. I 
> simply add
> 
> deb http://dagobah.ucc.asn.au/ubuntu-suspend2 dapper/

Okay, so do that and bye bye...

> Yes, suspend2 is more complex than what is in the kernel.. but whadda ya 
> know.. it works. Perhaps that extra complexity is there for a
> reason..

Perhaps not. Even Nigel understands that compression/encryption does
not _have_ to be there.
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
