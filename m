Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264405AbUEEKMN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264405AbUEEKMN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 May 2004 06:12:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264440AbUEEKMN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 May 2004 06:12:13 -0400
Received: from gprs214-31.eurotel.cz ([160.218.214.31]:14976 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S264405AbUEEKMJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 May 2004 06:12:09 -0400
Date: Wed, 5 May 2004 12:11:58 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <ncunningham@linuxmail.org>
Cc: Andrew Morton <akpm@zip.com.au>,
       Rusty trivial patch monkey Russell 
	<trivial@rustcorp.com.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: swsusp documentation updates
Message-ID: <20040505101158.GC1361@elf.ucw.cz>
References: <20040505094719.GA4259@elf.ucw.cz> <1083750907.17294.27.camel@laptop-linux.wpcb.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1083750907.17294.27.camel@laptop-linux.wpcb.org.au>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > +There are two solutions to this:
> > +
> > +* require half of memory to be free during suspend. That way you can
> > +read "new" data onto free spots, then cli and copy
> 
> Would you consider adding:
> 
> (Suspend2, which allows more than half of memory to be saved, is a
> variant on this).

How would you like this added?

swsusp2 shares this fundamental limitation, but does not include user
data and disk caches into "used memory" by saving them in
advance. That means that limitation goes away in practice.

And perhaps you want to write "What is swsusp2?" question/answer?

								Pavel
-- 
934a471f20d6580d5aad759bf0d97ddc
