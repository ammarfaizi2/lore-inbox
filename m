Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030447AbWEYVqT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030447AbWEYVqT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 17:46:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030450AbWEYVqT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 17:46:19 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:29407 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1030447AbWEYVqT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 17:46:19 -0400
Date: Thu, 25 May 2006 23:45:31 +0200
From: Pavel Machek <pavel@suse.cz>
To: Paul Jackson <pj@sgi.com>
Cc: dzickus@redhat.com, linux-kernel@vger.kernel.org, ak@suse.de
Subject: Re: [PATCH] Allow users to force a panic on NMI
Message-ID: <20060525214530.GD6347@elf.ucw.cz>
References: <20060511214933.GU16561@redhat.com> <20060518191700.GC5846@ucw.cz> <20060525103916.5d5501d8.pj@sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060525103916.5d5501d8.pj@sgi.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Čt 25-05-06 10:39:16, Paul Jackson wrote:
> > >  	printk("Dazed and confused, but trying to continue\n");
> > 
> > 'Trying to contninue'
> 
> I'm pretty sure that the correct spelling is "continue",
> not "contninue".  Are you suggesting otherwise?

No, that was a typo. But it is wrong to print "...trying to continue"
message, when machine is going to be halted next milisecond.
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
