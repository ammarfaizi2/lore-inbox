Return-Path: <linux-kernel-owner+w=401wt.eu-S1759243AbWLJGuY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759243AbWLJGuY (ORCPT <rfc822;w@1wt.eu>);
	Sun, 10 Dec 2006 01:50:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760131AbWLJGuY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Dec 2006 01:50:24 -0500
Received: from smtp.osdl.org ([65.172.181.25]:56588 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759243AbWLJGuX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Dec 2006 01:50:23 -0500
Date: Sat, 9 Dec 2006 22:50:14 -0800
From: Andrew Morton <akpm@osdl.org>
To: Michael Westermann <michael@dvmwest.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: DTR/DSR handshake in kernelspace third traying
Message-Id: <20061209225014.0888720b.akpm@osdl.org>
In-Reply-To: <20061207201626.GA10920@dvmwest.dvmwest.de>
References: <20061207201626.GA10920@dvmwest.dvmwest.de>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.19; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Thu, 7 Dec 2006 21:16:27 +0100 Michael Westermann <michael@dvmwest.de> wrote:
> Hello,
> 
> I've send 2 patches for a DTS/DSR handshaking to the list
> 
> http://lkml.org/lkml/2004/5/7/76  and long long time ago 1998
> 
> My problem are manufacturers the make printers with
> DTR/DSR Handschaking. POS Printers are very sensible for
> a buffer overrun!
> 
> For on or two printers, we can wire a adapter, for 10000...30000
> printers is a software option the better way.
> 
> I've write a patch for 2.2 and published it, 
> I've write a patch for 2.4 and published it, but i've see there is no
> 
> DTR/DSR Handshaking in the kernel 2.6.
> 
> I'm a litte bit  frusted. Are a few  thousands pos-systems not
> enough for upgrading the standard kernel sources?
> 
> Have I a really chance to commit a patch for kernel 2.6.
> 

I'd say so.  Please make sure that such a patch is against the very latest
Linus kernel from ftp://ftp.kernel.org/pub/linux/kernel/v2.6/snapshots. 
Also, the more comprehensive the patch's description the better - why it is
needed, what it does, how it works, etc.  Your 2004 description was rather
terse.

I seem to recall that the people who understand and work on this code
discussed this issue earlier this year, but I forget the conclusion.  Some
archive searching might be useful.
