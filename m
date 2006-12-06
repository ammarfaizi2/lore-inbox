Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937709AbWLFWTT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937709AbWLFWTT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 17:19:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937713AbWLFWTT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 17:19:19 -0500
Received: from pfepa.post.tele.dk ([195.41.46.235]:52861 "EHLO
	pfepa.post.tele.dk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S937709AbWLFWTT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 17:19:19 -0500
Subject: Re: BUG? atleast >=2.6.19-rc5, x86 chroot on x86_64
From: Kasper Sandberg <lkml@metanurb.dk>
To: Andi Kleen <ak@muc.de>
Cc: Chuck Ebbert <76306.1226@compuserve.com>,
       David Howells <dhowells@redhat.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>, vojtech@suse.cz
In-Reply-To: <20061206212915.GA31447@muc.de>
References: <200612052134_MC3-1-D40B-A5DB@compuserve.com>
	 <1165409880.15706.9.camel@localhost>  <20061206212915.GA31447@muc.de>
Content-Type: text/plain
Date: Wed, 06 Dec 2006 23:19:00 +0100
Message-Id: <1165443540.31851.6.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-12-06 at 22:29 +0100, Andi Kleen wrote:
> > and i am very very sure its because of this, i can run with the kernel
> > (atleast with rc5 i had that long) for 10 days, and then chroot in, run
> > the 32bit apps, and within hours of using, hardlock.
> 
> Early AMD K8 platforms had a hardware bug that could have caused
> such hardlocks when running 32bit code under 64bit (independent of anything 
> the kernel does). If you have such a board/CPU try a BIOS update.
well, 2.6.18 were 100% stable, none of these issues.

however you have caught my attention, cause i have one of the first
amd64's, a 3200+ 1mb cache, socket 754. and an asus board. ill try find
a floppy and upgrade the bios if there are updates available.
> 
> -Andi
> 

