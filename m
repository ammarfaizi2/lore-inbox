Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758365AbWK0THz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758365AbWK0THz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 14:07:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758535AbWK0THz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 14:07:55 -0500
Received: from cantor2.suse.de ([195.135.220.15]:17333 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1758365AbWK0THy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 14:07:54 -0500
Date: Mon, 27 Nov 2006 20:07:48 +0100
From: Andi Kleen <ak@suse.de>
To: Olivier Galibert <galibert@pobox.com>, Andi Kleen <ak@suse.de>,
       linux-pci@atrey.karlin.mff.cuni.cz,
       "Hack inc." <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] PCI MMConfig: Detect and support the E7520 and the 945G/GZ/P/PL
Message-ID: <20061127190748.GA7015@bingen.suse.de>
References: <20061123195137.GA35120@dspnet.fr.eu.org> <200611252159.59414.ak@suse.de> <20061126131532.GA41703@dspnet.fr.eu.org> <200611262028.04638.ak@suse.de> <20061127190301.GA75765@dspnet.fr.eu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061127190301.GA75765@dspnet.fr.eu.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 27, 2006 at 08:03:01PM +0100, Olivier Galibert wrote:
> On Sun, Nov 26, 2006 at 08:28:04PM +0100, Andi Kleen wrote:
> > On Sunday 26 November 2006 14:15, Olivier Galibert wrote:
> > > Ok, here you go, what about that?  I'll be able to test it on i386 on
> > > monday, not before.  It's hard to doa full 32bits install remotely :-)
> > 
> > Sorry, please don't put it all into a single patch. Do one patch
> > that just moves code, then add new functionality later.
> > Otherwise nobody can review it properly.
> 
> Ok, I have it split in 5 parts, but the testing on i386 failed simply
> because the vanilla code there just does not work.  Symptom is the
> SATA driver not seeing the disk somehow.

Weird. That shouldn't happen.

Is that with just the code movement patch or your feature patch
added too? If the later can you test it with only code movement
(and compare against vanilla kernel). at least code movement
only should behave exactly the same as unpatched kernel.

-Andi
