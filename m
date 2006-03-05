Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751506AbWCIUuj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751506AbWCIUuj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 15:50:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751499AbWCIUuj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 15:50:39 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:25617 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S1751506AbWCIUui
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 15:50:38 -0500
Date: Sun, 5 Mar 2006 00:37:59 +0000
From: Pavel Machek <pavel@ucw.cz>
To: Kasper Sandberg <lkml@metanurb.dk>
Cc: Thomas Maier <Thomas.Maier@uni-kassel.de>, linux-kernel@vger.kernel.org
Subject: Re: [Suspend2-announce] Nigel's work and the future of Suspend2.
Message-ID: <20060305003758.GA2669@ucw.cz>
References: <200603071005.56453.nigel@suspend2.net> <1141737241.5386.28.camel@marvin.se.eecs.uni-kassel.de> <20060308122500.GB3274@elf.ucw.cz> <1141903990.1745.5.camel@localhost> <20060309114556.GE2813@elf.ucw.cz> <1141916144.1745.8.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1141916144.1745.8.camel@localhost>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 09-03-06 15:55:44, Kasper Sandberg wrote:
> On Thu, 2006-03-09 at 12:45 +0100, Pavel Machek wrote:
> > > > > Mainline swsusp never worked for me and
> > > > > so with you leaving I am tempted to leave Linux behind after more than
> > > > > ten years and switch to that other OS that at least has working suspend
> > > > > and resume.  
> > > didnt work on my laptop either, or one of my friends where i tried..
> > > however, swsusp2 does..
> > 
> > bugzilla IDs?
> have none, and i know this is very bad, however i didnt feel like i had
> any useful information to contribute, all i get is black screen, nothing
> to syslog, i have no serial port on my laptop..

printk/mdelay seems to work pretty well for swsusp debugging. As does
trying it again with as little modules as possible.

> > Except that suspend2 is not going to be merged, for variety of
> > reasons. One of them is that noone is working on merging it...
> > 
> one of them being the operative word, afaik, nigel was unwilling to work
> on the issues needed for merging for the reason that it wouldnt be
> merged..
> 
> out of personal interrest, why is it that prevents suspend2 from being
> merged?

Mostly doing too much stuff in kernel, see archives for details.

-- 
Thanks, Sharp!
