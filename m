Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751257AbWCTSpU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751257AbWCTSpU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 13:45:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751259AbWCTSpU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 13:45:20 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:45218 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751257AbWCTSpT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 13:45:19 -0500
Date: Mon, 20 Mar 2006 19:44:59 +0100
From: Pavel Machek <pavel@suse.cz>
To: Peter Wainwright <prw@ceiriog.eclipse.co.uk>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Announcing crypto suspend
Message-ID: <20060320184459.GB24523@elf.ucw.cz>
References: <20060320080439.GA4653@elf.ucw.cz> <1142879707.9475.4.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1142879707.9475.4.camel@localhost.localdomain>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Thanks to Rafael's great work, we now have working encrypted suspend
> > and resume. You'll need recent -mm kernel, and code from
> > suspend.sf.net. Due to its use of RSA, you'll only need to enter
> > password during resume.
> > 
> > [Code got some minimal review; if you are a crypto expert, and think
> > you can poke a hole within it, please try to do so.]
> > 								Pavel
> Thats pretty interesting - we really need a featureful suspend
> implementation
> in mainline. But there doesn't seem to be much documentation for it.
> suspend.sf.net takes me to the Suspend 2 site: www.suspend2.net (a
> virtual
> server?). Which code from this site is needed for the mainline suspend?

suspend.sf.net works for me , can you check again?

Anyway, all the code that is needed is here:

cvs -z3 -d:pserver:anonymous@cvs.sourceforge.net:/cvsroot/suspend co suspend

Installation is little tricky, but there's HOWTO file in repository.

								Pavel
-- 
Picture of sleeping (Linux) penguin wanted...
