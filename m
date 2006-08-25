Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932071AbWHYN32@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932071AbWHYN32 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 09:29:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932095AbWHYN32
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 09:29:28 -0400
Received: from cavan.codon.org.uk ([217.147.92.49]:25488 "EHLO
	vavatch.codon.org.uk") by vger.kernel.org with ESMTP
	id S932071AbWHYN31 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 09:29:27 -0400
Date: Fri, 25 Aug 2006 14:29:19 +0100
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: moreau francis <francis_moreau2000@yahoo.fr>
Cc: Richard Purdie <rpurdie@rpsys.net>,
       Russell King <rmk+lkml@arm.linux.org.uk>, linux-pm@lists.osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: Re : Re : [HELP] Power management for embedded system
Message-ID: <20060825132919.GA12370@srcf.ucam.org>
References: <20060824162034.GB19753@srcf.ucam.org> <20060825131843.87416.qmail@web25803.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060825131843.87416.qmail@web25803.mail.ukl.yahoo.com>
User-Agent: Mutt/1.5.9i
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mjg59@codon.org.uk
X-SA-Exim-Scanned: No (on vavatch.codon.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 25, 2006 at 01:18:43PM +0000, moreau francis wrote:
> Matthew Garrett wrote:
> > Triggering suspend/resume is already generic in the form of the 
> > /sys/power/state interface. There's been discussion of producing a 
> > generic battery class lately. There's some trend towards tying suspend 
> > requests into the input layer, but how appropriate that is may depend on 
> > the hardware in question. I think most of the pieces are in place to 
> > provide an interface that isn't tied to looking like APM, and there's
> 
> what about suspend/resume event handling ? Is there something already in
> place ?

You mean passing those events out to userspace? Not that I know of.
-- 
Matthew Garrett | mjg59@srcf.ucam.org
