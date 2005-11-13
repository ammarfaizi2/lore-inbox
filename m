Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750747AbVKMBLV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750747AbVKMBLV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Nov 2005 20:11:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750748AbVKMBLV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Nov 2005 20:11:21 -0500
Received: from ns1.suse.de ([195.135.220.2]:48045 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750747AbVKMBLV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Nov 2005 20:11:21 -0500
To: Mark Lord <lkml@rtr.ca>
Cc: Jeff Garzik <jgarzik@pobox.com>, Jan Beulich <JBeulich@novell.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/39] NLKD - Novell Linux Kernel Debugger
References: <43720DAE.76F0.0078.0@novell.com> <43722AFC.4040709@pobox.com>
	<1131558785.6540.34.camel@localhost.localdomain>
	<43735DCA.7060107@rtr.ca>
From: Andi Kleen <ak@suse.de>
Date: 13 Nov 2005 02:11:17 +0100
In-Reply-To: <43735DCA.7060107@rtr.ca>
Message-ID: <p73psp54aiy.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Lord <lkml@rtr.ca> writes:

> Alan Cox wrote:
> >
> > I think it is clearly the case that the design is wrong. The existance
> > of kgdb shows how putting the complex logic remotely on another system
> > is not only a lot cleaner and simpler but can also provide more
> > functionality and higher reliability.
> 
> Unless the target machine is modern (2005+ era) and has no serial ports,
> nor any way to add them other than via the USB stack.

Firewire looks most promising actually right now, at least for Desktop/Laptop
type systems. And servers still have serial ports right now, either in
hardware or simulated in some way.

-Andi
