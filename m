Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265977AbTGAFeQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jul 2003 01:34:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265979AbTGAFeQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jul 2003 01:34:16 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:11790 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S265977AbTGAFeA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jul 2003 01:34:00 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: PCI domain stuff
Date: 30 Jun 2003 22:47:50 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <bdr7a6$4eu$1@cesium.transmeta.com>
References: <1057010214.1277.11.camel@albertc> <20030630231515.GA27813@kroah.com> <20030701040531.GB23597@parcelfarce.linux.theplanet.co.uk> <1057034041.31826.1.camel@rth.ninka.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2003 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <1057034041.31826.1.camel@rth.ninka.net>
By author:    "David S. Miller" <davem@redhat.com>
In newsgroup: linux.dev.kernel
>
> On Mon, 2003-06-30 at 21:05, Matthew Wilcox wrote:
> > We need to support mmaping device resources.  I think this actually
> > merits being a first class sysfs concept -- turn a struct resource into
> > an mmapable file.  The current fugly ioctl really has to go.
> 
> What's so wrong with the "fugly ioctl"?
> 
> What can't you do with it?
> 
> You can even mmap the complete I/O space of a PCI bus (in order to poke
> around in implicit I/O resources like the VGA registers that a PCI card
> might respond to).
> 

Presumably only on architectures which use memory-mapped IO address
space.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
Architectures needed: ia64 m68k mips64 ppc ppc64 s390 s390x sh v850 x86-64
