Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262848AbUA3RVr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jan 2004 12:21:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262888AbUA3RVr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jan 2004 12:21:47 -0500
Received: from gprs116-76.eurotel.cz ([160.218.116.76]:27265 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262848AbUA3RVo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jan 2004 12:21:44 -0500
Date: Fri, 30 Jan 2004 18:01:08 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Cc: Mark Borgerding <mark@borgerding.net>,
       Michael A Halcrow <mahalcro@us.ibm.com>,
       Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: Encrypted Filesystem
Message-ID: <20040130170108.GA625@elf.ucw.cz>
References: <OFA97B290B.67DE842E-ON87256E27.0061728C-86256E27.0061BB0E@us.ibm.com> <40156546.1050809@borgerding.net> <1075151094.809.11.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1075151094.809.11.camel@teapot.felipe-alfaro.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Have you given any thought to journalling? fscking? Can directory 
> > contents be encrypted?  If so, what does the dir look like to others 
> > (e.g. backup utils)
> > 
> > Per-file signatures will severely affect random access performance.  
> > Changing 1 byte in a 1 GB file would require the whole thing to be reread.
> 
> What about calculating signatures on a per-block basis instead?

Hmm, having md5's in indirect blocks would be very nice for detecting
cable problems ;-). That's usefull even without encryption.
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
