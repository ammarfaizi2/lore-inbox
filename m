Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263361AbTJBPaQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Oct 2003 11:30:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263375AbTJBPaQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Oct 2003 11:30:16 -0400
Received: from mta1.cl.cam.ac.uk ([128.232.0.15]:31105 "EHLO
	wisbech.cl.cam.ac.uk") by vger.kernel.org with ESMTP
	id S263361AbTJBPaN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Oct 2003 11:30:13 -0400
To: John Bradford <john@grabjohn.com>
cc: xen-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [Xen-devel] Re: [ANNOUNCE] Xen high-performance x86 virtualization 
In-Reply-To: Your message of "Thu, 02 Oct 2003 16:15:01 BST."
             <200310021515.h92FF1N3000239@81-2-122-30.bradfords.org.uk> 
Date: Thu, 02 Oct 2003 16:30:04 +0100
From: Keir Fraser <Keir.Fraser@cl.cam.ac.uk>
Message-Id: <E1A55P2-00065x-00@wisbech.cl.cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Our aim was to implement an efficient VMM for commodity hardware, and
> > that really means x86. We're considering a port to x86-64, but so far
> > we're limited in man power (this is why *BSD is not yet available, for
> > example). 
> 
> Does it run recursively?  I.E. can you can Xen within a Xen virtual
> machine for development and testing purposes?

No --- Xen runs on x86 but exports a different 'x86-xeno' virtual
architecture that OSes must be ported to (basically, privileged ops
must go through Xen for validation).

x86 != x86-xeno, so Xen will not run on Xen.

 -- Keir
