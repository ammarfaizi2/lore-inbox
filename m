Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263930AbUAZShS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jan 2004 13:37:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264374AbUAZShS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jan 2004 13:37:18 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:9993 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S263930AbUAZShR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jan 2004 13:37:17 -0500
Date: Mon, 26 Jan 2004 18:37:15 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Peter Matthias <espi@epost.de>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] rivafb & small 16 bit mode problem
In-Reply-To: <58drub.99.ln@ulysses.tiscali.de>
Message-ID: <Pine.LNX.4.44.0401261836200.1880-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Jan 2004, Peter Matthias wrote:

> Ingo Buescher schrieb:
> 
> > On Thu, 22 Jan 2004, [iso-8859-2] Pawe? Goleniowski wrote:
> > 
> >> But I have no idea which options should I send to kernel to get different
> >> resolution (video=riva:800x600-16@85 don't work) and I have very ugly
> Linux
> >> logo while booting ;)
> > 
> > video=rivafb:800x600-16@85
> >           ^^
> > 
> > should work
> 
> Well, even this does not work on my nforce 2 integrated grafics. Any clues?

Its a bug in the driver in both 2.4.X and 2.6.X. I have some patches for 
i2c support but mode changing still didn't work for me :-(


