Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282173AbRKWQUx>; Fri, 23 Nov 2001 11:20:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282174AbRKWQUo>; Fri, 23 Nov 2001 11:20:44 -0500
Received: from mandrakesoft.mandrakesoft.com ([216.71.84.35]:23920 "EHLO
	mandrakesoft.mandrakesoft.com") by vger.kernel.org with ESMTP
	id <S282173AbRKWQU1>; Fri, 23 Nov 2001 11:20:27 -0500
Date: Fri, 23 Nov 2001 10:20:22 -0600 (CST)
From: Jeff Garzik <jgarzik@mandrakesoft.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Leif Sawyer <lsawyer@gci.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>, leif@denali.net
Subject: RE: Linux-2.4.15-pre9
In-Reply-To: <Pine.LNX.4.33.0111221417001.1006-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.3.96.1011123101917.32257B-100000@mandrakesoft.mandrakesoft.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Nov 2001, Linus Torvalds wrote:
> On Thu, 22 Nov 2001, Leif Sawyer wrote:
> >
> > adding the 'pci=biosirq' to my kernel boot command line causes an oops:
> 
> Well, you seem to have a buggered BIOS - the oops is actually in the BIOS
> segment, and the BIOS appears to try to re-load the ES segment register
> with some strange non-existing segment.
> 
> Your BIOS PCI irq routing routines probably only work in real-mode or
> something like that.

There are bugs in PCI recently...  I got a report showing a machine that
booted fine into 2.4.8, but in 2.4.15 reports "this system does not
support PCI" right after it -detects- PCIBIOS successfully.  He got
tired of debuggin before I could get more info :(

	Jeff



