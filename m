Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264072AbTKJTMx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Nov 2003 14:12:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264073AbTKJTMx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Nov 2003 14:12:53 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:22803 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S264072AbTKJTMu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Nov 2003 14:12:50 -0500
Date: Mon, 10 Nov 2003 14:01:59 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Linus Torvalds <torvalds@osdl.org>
cc: John Bradford <john@grabjohn.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.9test9-mm1 and DAO ATAPI cd-burning corrupt
In-Reply-To: <Pine.LNX.4.44.0311070652080.1842-100000@home.osdl.org>
Message-ID: <Pine.LNX.3.96.1031110135419.6278B-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Nov 2003, Linus Torvalds wrote:

> 
> On Fri, 7 Nov 2003, Bill Davidsen wrote:
> > 
> > I mentioned ide tapes and ZIP drives, Linus didn't mention how one gets
> > around those.
> 
> The thing is, the non-ide-scsi interfaces really _should_ work. The fact
> is, SG_IO ("send a SCSI command") just _works_.
> 
> However, right now only the CD-ROM driver exposes those commands. Why? 
> Because nobody has apparently cared enough about those theoretical IDE 
> tapes and ZIP drives.
> 
> In other words, they seem to "exist" in the same sense that soubdblaster 
> CD-ROM users "exist". True in theory, but apparently only really useful 
> for theoretical arguments.

I take it that if the IDE maintainer and you don't use a device it will
not be supported in the future? There's nothing theoretical about ZIP
drives and ATAPI tape drives, you can order them mail order or buy them at
any computer show. And 2.4 ide-scsi seems to support them perfectly, or at
least usefully, which is probably why there haven't been any complaints.

I admit I can't understand why 2.6 supports old NICs and motherboard
chipsets which haven't been made in five years, and then deliberately
desupports devices which did work and which are available at computer
stores and mail order today.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

