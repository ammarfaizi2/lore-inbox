Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030315AbWAGB3T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030315AbWAGB3T (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 20:29:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030312AbWAGB3S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 20:29:18 -0500
Received: from smtp.osdl.org ([65.172.181.4]:60290 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030307AbWAGB3Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 20:29:16 -0500
Date: Fri, 6 Jan 2006 17:30:22 -0800
From: Andrew Morton <akpm@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org, arjan@infradead.org,
       nico@cam.org, jes@trained-monkey.org, viro@ftp.linux.org.uk,
       oleg@tv-sign.ru, dhowells@redhat.com, alan@lxorguk.ukuu.org.uk,
       hch@infradead.org, ak@suse.de, rmk+lkml@arm.linux.org.uk
Subject: Re: [patch 17/21] mutex subsystem, semaphore to mutex: automatic
 conversion of simpler cases
Message-Id: <20060106173022.3df929dd.akpm@osdl.org>
In-Reply-To: <20060107010749.GA6267@elte.hu>
References: <20060105153903.GR31013@elte.hu>
	<20060106170146.7e19a968.akpm@osdl.org>
	<20060107010749.GA6267@elte.hu>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@elte.hu> wrote:
>
> 
> * Andrew Morton <akpm@osdl.org> wrote:
> 
> > I think I'll duck this one for now.
> > 
> > Perhaps it should be split up a bit?
> 
> yeah, i'll merge it tomorrow and will split it up into per-driver 
> patches. Could you upload an x.bz2 i should merge against - or is 
> Linus-curr OK?
> 

The old x.bz2 would be better please, because I'm going to have to do
fixups for various -mm-only things like dlm, asfs, reiser4, etc.

http://www.zip.com.au/~akpm/linux/patches/stuff/up-to-mutex-series.bz2

Is everything up to and including the mutex series.  That's a suitable
insertion point for new stuff.

http://www.zip.com.au/~akpm/linux/patches/stuff/everything.bz2 is the whole
kit.  It includes additional things which'll need fixups if you're feeling
keen.

Sorry for the hassle - there are still great gobs of stuff to merge, and
we're basically twiddling thumbs until things like nfs, powerpc, usb get
merged.
