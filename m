Return-Path: <linux-kernel-owner+w=401wt.eu-S1763086AbWLKUaL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763086AbWLKUaL (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 15:30:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937647AbWLKUaK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 15:30:10 -0500
Received: from gate.crashing.org ([63.228.1.57]:41089 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1763086AbWLKUaJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 15:30:09 -0500
Subject: Re: powerpc: "IRQ probe failed (0x0)" on powerbook
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, linux-kernel@vger.kernel.org
In-Reply-To: <20061211112017.GA16399@infradead.org>
References: <87lklg9rkz.fsf@briny.internal.ondioline.org>
	 <20061211112017.GA16399@infradead.org>
Content-Type: text/plain
Date: Tue, 12 Dec 2006 07:28:23 +1100
Message-Id: <1165868903.7260.53.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-12-11 at 11:20 +0000, Christoph Hellwig wrote:
> On Sun, Dec 10, 2006 at 07:45:48PM +1300, Paul Collins wrote:
> > On my PowerBook when booting Linus's tree as of commit af1713e0 I get
> > something like this:
> > 
> >   [blah blah]
> >   ide0: Found Apple UniNorth ATA-6 controller, bus ID 3, irq 0
> >   Probing IDE interface ide0...
> >   hda: HTS541080G9AT00, ATA DISK drive
> >   IRQ probe failed (0x0)
> >   IRQ probe failed (0x0)
> >   IRQ probe failed (0x0)
> >   IRQ probe failed (0x0)
> > 
> > And then of course it fails to mount root.  No such problem using a
> > kernel built from commit 97be852f of December 2nd.
> 
> Same here, btw - except that I couldn't catch the exact message as
> nicely.

Yeah, fixed in the patch I sent yesterday [PATCH] powerpc: Fix irq
routing on some PowerMac 32 bit.

Ben



