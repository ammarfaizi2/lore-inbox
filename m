Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262848AbUAELfU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 06:35:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263221AbUAELfU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 06:35:20 -0500
Received: from pileup.ihatent.com ([217.13.24.22]:10713 "EHLO
	pileup.ihatent.com") by vger.kernel.org with ESMTP id S262848AbUAELfO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 06:35:14 -0500
To: earny@net4u.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0 under vmware ?
References: <1073297203.12550.30.camel@bip.parateam.prv>
	<200401051221.30398.earny@net4u.de>
From: Alexander Hoogerhuis <alexh@ihatent.com>
Date: 05 Jan 2004 12:35:04 +0100
In-Reply-To: <200401051221.30398.earny@net4u.de>
Message-ID: <87u13aaas7.fsf@lapper.ihatent.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ernst Herzberg <earny@net4u.de> writes:

> On Montag, 5. Januar 2004 11:06, Xavier Bestel wrote:
> > Hi,
> >
> > I have problems running 2.6.0 under vmware (4.02 and 4.05). I did a
> > basic debian/sid install, then installed various 2.6.0 kernel images
> > (with or without initrd, from debian (-test9 and -test11) or self-made
> > (stock 2.6.0).
> > They all make /sbin/init (from sysvinit 2.85) segfault at a particular
> > address (I haven't yet recompiled it with -g to see where, but a
> > dissassembly shows it's a "ret").
> > I try booting to /bin/sh from the initrd, and there I can play with the
> > shell, mount the alternate root, play with commands there, and then exec
> > /sbin/init, but it segfaults at the same point.
> >
> > Has anyone managed to make a basic debian with 2.6 work under vmware ?
> > Has anyone managed to make another distro with 2.6 work under vmware ?
> 
> Same problem here. Tried gentoo with 2.6.0 and 2.6.1-rc1: /sbin/init will 
> segfault. Testet vmware on a Dual PIII 2.4.23-pre3 and a Athlon XP with 
> 2.6.1-rc1.
> 

Ack that, P4 with 2.6.0-mmX and 2.6.1-rc1-mmX :)

> Earny
> 

-- 
Alexander Hoogerhuis                               | alexh@ihatent.com
CCNP - CCDP - MCNE - CCSE                          | +47 908 21 485
"You have zero privacy anyway. Get over it."  --Scott McNealy
