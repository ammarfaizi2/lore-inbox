Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263678AbTDNSUX (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 14:20:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263687AbTDNSUV (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 14:20:21 -0400
Received: from smtpzilla5.xs4all.nl ([194.109.127.141]:3849 "EHLO
	smtpzilla5.xs4all.nl") by vger.kernel.org with ESMTP
	id S263678AbTDNSTk (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 14 Apr 2003 14:19:40 -0400
Date: Mon, 14 Apr 2003 20:31:21 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Linus Torvalds <torvalds@transmeta.com>
cc: Andries.Brouwer@cwi.nl, Andrew Morton <akpm@digeo.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] kdevt-diff
In-Reply-To: <Pine.LNX.4.44.0304141116020.19302-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44.0304142022370.5042-100000@serv>
References: <Pine.LNX.4.44.0304141116020.19302-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 14 Apr 2003, Linus Torvalds wrote:

> > Linus, if you still want to go for a single block device major, this patch 
> > is bad idea (at least in this form).
> 
> I disagree.
> 
> I think the single block-device major is a totally separate issue, and has 
> nothing to do with allowing big device_t representations. I do not see why 
> Andries patch would be anything else than infrastructure for future 
> expansion.

Expansion into what?
The knowledge about dev_t is already reduced to a minimum in a lot of 
block device drivers. register_blkdev() is already pretty much a dummy and 
not a requirement anymore.

bye, Roman

