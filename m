Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264286AbTLESqg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 13:46:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264320AbTLESo6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 13:44:58 -0500
Received: from fw.osdl.org ([65.172.181.6]:64667 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264294AbTLESoc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 13:44:32 -0500
Date: Fri, 5 Dec 2003 10:44:28 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Jeff Garzik <jgarzik@pobox.com>
cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [BK PATCHES] libata fixes
In-Reply-To: <20031205181643.GA6877@gtf.org>
Message-ID: <Pine.LNX.4.58.0312051041000.9125@home.osdl.org>
References: <20031205181643.GA6877@gtf.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 5 Dec 2003, Jeff Garzik wrote:
>
> Linus, please do a
>
> 	bk pull bk://gkernel.bkbits.net/libata-2.5
>
> This will update the following files:
>
>  drivers/scsi/libata-core.c  |   17 ++---
>  drivers/scsi/sata_promise.c |  128 +++++++++++++++++++++++++-------------------

Right now, I'm accepting one-liners that I think are "obvious" and also
"very important" (ie fixes for oopses that anybody can trigger, rather
than for example updates to one particular driver). So it sounds like I
might accept _one_ of these:

> <jgarzik@redhat.com> (03/12/05 1.1498)
>    [libata] fix use-after-free
>
>    Fixes oops some were seeing on module unload.
>
>    Caught by Jon Burgess.

If this is basically an obvious one-liner ("move a kfree")?

Andrew is still off, and he can make a decision independently, but right
now I'm not going to apply anything bigger.

		Linus
