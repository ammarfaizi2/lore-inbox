Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263847AbTFYDkp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jun 2003 23:40:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263859AbTFYDkp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jun 2003 23:40:45 -0400
Received: from pcp03710388pcs.westk01.tn.comcast.net ([68.34.200.110]:48258
	"EHLO ori.thedillows.org") by vger.kernel.org with ESMTP
	id S263847AbTFYDko (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jun 2003 23:40:44 -0400
Subject: Re: 2.4.21: kernel BUG at ide-iops.c:1262!
From: David Dillow <dave@thedillows.org>
To: Scott McDermott <vaxerdec@frontiernet.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20030624204828.I30001@newbox.localdomain>
References: <1056493150.2840.17.camel@ori.thedillows.org>
	 <20030624204828.I30001@newbox.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1056513292.3885.2.camel@ori.thedillows.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 24 Jun 2003 23:54:52 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-06-24 at 20:48, Scott McDermott wrote:
> David Dillow on Tue 24/06 18:19 -0400:
> > I've found a completely repeatable BUG/panic in 2.4.21
> > (final). The kernel BUGS and then panics in an interrupt
> > while beginning to burn a DVD+R. I get the following in
> > the logs, then the BUG/panic decoded at the end of this
> > message:
> 
> There were recent threads about this, and a Bugzilla bug 829
> I think.  

Doh! Missed those, and my quick search didn't hit. Found one after your
message, though.

> Try killing magicdev.

I thought I had, but upon checking, it was still kicking. Killing it
allows the burn to complete uninterrupted.

I'll test patches to kill the kernel BUG, but I'm happy to be able to
burn without a reboot again.

Dave
