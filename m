Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262723AbVFWTaL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262723AbVFWTaL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 15:30:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262705AbVFWTXn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 15:23:43 -0400
Received: from atlrel7.hp.com ([156.153.255.213]:63121 "EHLO atlrel7.hp.com")
	by vger.kernel.org with ESMTP id S262722AbVFWTUh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 15:20:37 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Jens Axboe <axboe@suse.de>
Subject: Re: SMP+irq handling broken in current git?
Date: Thu, 23 Jun 2005 13:20:28 -0600
User-Agent: KMail/1.8.1
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org
References: <20050623135318.GC9768@suse.de> <200506231258.35258.bjorn.helgaas@hp.com> <20050623191146.GB6814@suse.de>
In-Reply-To: <20050623191146.GB6814@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506231320.28172.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 23 June 2005 1:11 pm, Jens Axboe wrote:
> On Thu, Jun 23 2005, Bjorn Helgaas wrote:
> > On Thursday 23 June 2005 12:42 pm, Jens Axboe wrote:
> > > On Thu, Jun 23 2005, Jeff Garzik wrote:
> > > > Jens Axboe wrote:
> > > > >Hi,
> > > > >
> > > > >Something strange is going on with current git as of this morning (head
> > > > >ee98689be1b054897ff17655008c3048fe88be94). On an old test box (dual p3
> > > > >800MHz), using the same old config I always do on this box has very
> > > > >broken interrupt handling:
> > > > 
> > > > Does 2.6.12 work for you?
> > > > 2.6.11?
> > > 
> > > 2.6.11 works, 2.6.12 does not.
> > 
> > Do you have any VIA devices?  If so, you might try the attached.
> > (Just for debugging; if the patch helps, I have no idea how to
> > do it correctly.)
> 
> No VIA devices, it's an intel board with intel chipset. Do you still
> want me to test it?

Nope, I don't think it will make any difference then.
