Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264248AbTGKQoS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 12:44:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264256AbTGKQoS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 12:44:18 -0400
Received: from host-64-213-145-173.atlantasolutions.com ([64.213.145.173]:65493
	"EHLO havoc.gtf.org") by vger.kernel.org with ESMTP id S264248AbTGKQoP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 12:44:15 -0400
Date: Fri, 11 Jul 2003 12:58:58 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: Pekka Pietikainen <pp@netppl.fi>
Cc: Bas Mevissen <bas@basmevissen.nl>, torvalds@transmeta.com,
       alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: REQ: BCM4400 network driver for 2.4.22
Message-ID: <20030711165858.GG2210@gtf.org>
References: <200307092333.36917.bas@basmevissen.nl> <3F0C9194.5060206@pobox.com> <20030711163345.GA23076@netppl.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030711163345.GA23076@netppl.fi>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 11, 2003 at 07:33:45PM +0300, Pekka Pietikainen wrote:
> On Wed, Jul 09, 2003 at 06:05:08PM -0400, Jeff Garzik wrote:
> > b44 in 2.5 supports this, and it will be backported to 2.4.
> > 
> > Pekka Pietikainen just identified several bugs, so those will get fixed 
> > in the next day or so, then b44 will be sent to Marcelo.
> Hi
> 
> Here's a patch against the driver version in 2.5.73 for testing/comments,
> which fixes all the issues I know of in the driver. I'm writing this mail
> through the driver running on 2.4.x, so obviously at least basic 
> functionality is working.
> 
> I'm not too sure about the pointer tricks I do with skb->data
> in b44_rx(), but they seem to do the trick just fine ;)

You rule, dude.  I'll give it a test here, too.

I've already merged a couple of your fixes locally, I'll suck the rest
of this patch into my queue ASAP.

If others could test this, that is much appreciated too.

	Jeff



