Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264496AbUD0X7Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264496AbUD0X7Q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 19:59:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264515AbUD0X7Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 19:59:16 -0400
Received: from stokkie.demon.nl ([82.161.49.184]:2453 "HELO stokkie.net")
	by vger.kernel.org with SMTP id S264496AbUD0X7L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 19:59:11 -0400
Date: Wed, 28 Apr 2004 01:59:08 +0200 (CEST)
From: "Robert M. Stockmann" <stock@stokkie.net>
To: Tim Hockin <thockin@hockin.org>
cc: Michael Poole <mdpoole@troilus.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Blacklist binary-only modules lying about their license
In-Reply-To: <20040427234136.GA17801@hockin.org>
Message-ID: <Pine.LNX.4.44.0404280149480.15618-100000@hubble.stokkie.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-AntiVirus: scanned for viruses by AMaViS 0.2.2 (ftp://crashrecovery.org/pub/linux/amavis/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Apr 2004, Tim Hockin wrote:

> On Wed, Apr 28, 2004 at 01:30:58AM +0200, Robert M. Stockmann wrote:
> > > What the hell do these two paragraphs have to do with each other?
> > 
> > C99 coding style, more specific the use of unnamed and anonymous structures
> > and unions, allows the kernel programmer to interface, read glue, binary only
> > driver modules to interface with any linux kernel source tree.
> 
> What the hell are you going on about?  Unnamed structures are a
> syntactical construct and have ZILCH to do with runtime.

I thought so too, until your semi open-source link kit is linked to that
brand-new linux kernel source tree, and at the same time the binary
components of your link-kit have become incompatible with that newer kernel. 

Result? one might even loose its data, upon booting that newly build
kernel and modules, in case your storage-controller has a binary only
link-kit as its driver.

> > The needed header files, which need to be read by the gcc compiler, contain
> > unnamed and annonymizes structures and unions. In the worst case scenario,
> > only the name of used variables are given and no info about variable type or
> > size are inside these headers files. gcc-2.95.3 fails to succesfully link these
> 
> Opaque types have been available FOREVER.

sure, but can one qualify that as Open Source?

Robert
-- 
Robert M. Stockmann - RHCE
Network Engineer - UNIX/Linux Specialist
crashrecovery.org  stock@stokkie.net

