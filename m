Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932187AbWC3MFj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932187AbWC3MFj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 07:05:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932183AbWC3MFj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 07:05:39 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:48558 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932186AbWC3MFi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 07:05:38 -0500
Date: Thu, 30 Mar 2006 14:05:14 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <ncunningham@cyclades.com>
Cc: Mark Lord <lkml@rtr.ca>, linux-kernel@vger.kernel.org
Subject: Re: Suspend2-2.2.2 for 2.6.16.
Message-ID: <20060330120514.GO8485@elf.ucw.cz>
References: <200603281601.22521.ncunningham@cyclades.com> <200603301944.27188.ncunningham@cyclades.com> <20060330115519.GN8485@elf.ucw.cz> <200603302159.05751.ncunningham@cyclades.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200603302159.05751.ncunningham@cyclades.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > I do not see missing includes, so I'm not sure it will help. Can you
> > try adding
> >
> > ARCH=x86_64
> >
> > to Makefile?
> 
> Heh. It worked. Maybe you should have something to figure out what arch the 
> user is using :) It seems a bit strange to tell the compiler that I'm using 
> the arch it ought to know I'm using.

Good. Does 

ARCH=`uname -m`

work, too? If so, I'll commit it... when sf.net gets up.
									Pavel

-- 
Picture of sleeping (Linux) penguin wanted...
