Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263868AbTK2Sjj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Nov 2003 13:39:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263886AbTK2Sjj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Nov 2003 13:39:39 -0500
Received: from havoc.gtf.org ([63.247.75.124]:46006 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S263868AbTK2Sji (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Nov 2003 13:39:38 -0500
Date: Sat, 29 Nov 2003 13:39:36 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: Miquel van Smoorenburg <miquels@cistron.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Silicon Image 3112A SATA trouble
Message-ID: <20031129183936.GA23744@gtf.org>
References: <3FC36057.40108@gmx.de> <3FC8BDB6.2030708@gmx.de> <20031129165648.GB14704@gtf.org> <bqalnq$knf$1@news.cistron.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bqalnq$knf$1@news.cistron.nl>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 29, 2003 at 05:41:14PM +0000, Miquel van Smoorenburg wrote:
> In article <20031129165648.GB14704@gtf.org>,
> Jeff Garzik  <jgarzik@pobox.com> wrote:
> >Note that (speaking technically) the SII libata driver doesn't mask all
> >interrupt conditions, which is why it's listed under CONFIG_BROKEN.  So
> >this translates to "you might get a random lockup", which some users
> >certainly do see.
> 
> That begs the question: is that going to be fixed ?

Certainly.


> Also, the low performance of the IDE SII driver is because of
> the bug with request-size (and the bad workaround). Was that
> fixed in the libata version and if so is someone working on
> porting that fix to the IDE version of the driver ?

It is fixed in the libata version.

	Jeff



