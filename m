Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967206AbWKYVAF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967206AbWKYVAF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Nov 2006 16:00:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967209AbWKYVAF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Nov 2006 16:00:05 -0500
Received: from ns.suse.de ([195.135.220.2]:48284 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S967206AbWKYVAE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Nov 2006 16:00:04 -0500
From: Andi Kleen <ak@suse.de>
To: Olivier Galibert <galibert@pobox.com>
Subject: Re: [PATCH] PCI MMConfig: Detect and support the E7520 and the 945G/GZ/P/PL
Date: Sat, 25 Nov 2006 21:59:59 +0100
User-Agent: KMail/1.9.5
Cc: linux-pci@atrey.karlin.mff.cuni.cz,
       "Hack inc." <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
References: <20061123195137.GA35120@dspnet.fr.eu.org> <200611252034.34378.ak@suse.de> <20061125205152.GA18964@dspnet.fr.eu.org>
In-Reply-To: <20061125205152.GA18964@dspnet.fr.eu.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611252159.59414.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 25 November 2006 21:51, Olivier Galibert wrote:
> On Sat, Nov 25, 2006 at 08:34:34PM +0100, Andi Kleen wrote:
> > On Thursday 23 November 2006 20:51, Olivier Galibert wrote:
> > 
> > > The detection and support should eventually be shared with i386 since
> > > you can run a 32bits kernel on a 64bits chip.
> > 
> > Exactly. So please define a mmconfig-shared.c first
> 
> Ok.  On which side (i386 or x86-64)

What you prefer. And please move the already existing shared code in there
too.

> and is there a standard way to 
> include the object file on the other side?

See arch/x86_64/kernel/Makefile for a few examples

-Andi
 
