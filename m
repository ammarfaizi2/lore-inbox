Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261249AbVGLH4y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261249AbVGLH4y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 03:56:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261253AbVGLH4x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 03:56:53 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:60594 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261249AbVGLH43 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 03:56:29 -0400
Date: Tue, 12 Jul 2005 09:56:20 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <ncunningham@cyclades.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] [42/48] Suspend2 2.1.9.8 for 2.6.12: 618-core.patch
Message-ID: <20050712075620.GC1854@elf.ucw.cz>
References: <11206164393426@foobar.com> <11206164443244@foobar.com> <20050710182106.GI10904@elf.ucw.cz> <1121151572.13869.42.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1121151572.13869.42.camel@localhost>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Have you seen Christoph's recent fixes to refrigerator? You probably
> > have same problems..... And he wanted to move refrigerator to sched/
> > and make it more generic for page migration, too... what about using
> > it, too? ;-).
> 
> Yeah. I'm using them already. I must say though that I don't think
> sched.h is necessarily the best place for the refrigerator defines. Any
> change to those functions and you have to recompile most of the kernel.
> Is a refrigerator.h an idea?

I do not think those recompiles pose a big problem; we don't want
million separate headers. I'd trust Christoph with this.
								Pavel
-- 
teflon -- maybe it is a trademark, but it should not be.
