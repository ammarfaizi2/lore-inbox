Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161027AbWALWfZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161027AbWALWfZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 17:35:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161357AbWALWfZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 17:35:25 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:50186 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1161027AbWALWfZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 17:35:25 -0500
Date: Thu, 12 Jan 2006 23:35:00 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Kyle McMartin <kyle@mcmartin.ca>
Cc: Adrian Bunk <bunk@stusta.de>, Matthew Wilcox <willy@parisc-linux.org>,
       linux-kernel@vger.kernel.org, parisc-linux@parisc-linux.org
Subject: Re: [parisc-linux] Re: [2.6 patch] arch/parisc/Makefile: remove GCC_VERSION
Message-ID: <20060112223500.GA9079@mars.ravnborg.org>
References: <20060112105157.GT29663@stusta.de> <20060112215237.GC8665@mars.ravnborg.org> <20060112215409.GD4701@quicksilver.road.mcmartin.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060112215409.GD4701@quicksilver.road.mcmartin.ca>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 12, 2006 at 04:54:09PM -0500, Kyle McMartin wrote:
> On Thu, Jan 12, 2006 at 10:52:37PM +0100, Sam Ravnborg wrote:
> > I assume the parisc people will take this one.
> >
> 
> I'm confused... you didn't mention at all what the benefit or reason
> for this is in your changelog entry...

In -mm a patch appeared that took for granted that GCC_VERSION was set.
So it seems that people started to think that GCC_VERSION was part of
the kbuild PAI and realibale. The best way to avoid this confusion was
to kill GCC_VERSION alltogether.

Andrew & I did it in most cases, and Adrian cleaned up parisc and killed
the last instance og GCC_VERSION there.

No functional changes, but a nice cleanup.

	Sam
