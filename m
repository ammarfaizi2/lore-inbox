Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263373AbTJZRrN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Oct 2003 12:47:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263383AbTJZRrN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Oct 2003 12:47:13 -0500
Received: from port5.ds1-sby.adsl.cybercity.dk ([212.242.169.198]:24626 "EHLO
	trider-g7.fabbione.net") by vger.kernel.org with ESMTP
	id S263373AbTJZRrJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Oct 2003 12:47:09 -0500
Date: Sun, 26 Oct 2003 18:47:07 +0100 (CET)
From: Fabio Massimo Di Nitto <fabbione@fabbione.net>
To: Jochen Hein <jochen@jochen.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4 <-> 2.6 compatibility
In-Reply-To: <871xt0ouei.fsf@echidna.jochen.org>
Message-ID: <Pine.LNX.4.58.0310261844580.8636@trider-g7.ext.fabbione.net>
References: <Pine.LNX.4.44.0310251152410.5764-100000@home.osdl.org>
 <20031026150544.GJ15838@merlin.emma.line.org> <871xt0ouei.fsf@echidna.jochen.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 26 Oct 2003, Jochen Hein wrote:

> Matthias Andree <matthias.andree@gmx.de> writes:
>
> > As 2.6 starts stabilizing, PLEASE try to synch up major components of
> > 2.6 and 2.4 so that the same user space can be used for either version.
> > It's fine with modutils and stuff, but when it comes to LVM, these 2.4
> > and 2.6 versions are a problem.
>
> Debian SID contains lvm10, lvm2 and lvm-common, which can be installed
> together and work for both kernels.  Backport to woody was simple.

this is true in terms of userland utils but you still need to perform a
transition of kernels. 2.4 -> 2.4 + devicemapper patch -> 2.6. Until now i
couldn't find a way to jump directly from 2.4 to 2.6 and converting from
lvm1 to lvm2 at the same time.

Fabio
