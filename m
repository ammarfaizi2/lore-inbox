Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937663AbWLFV3R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937663AbWLFV3R (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 16:29:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937668AbWLFV3R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 16:29:17 -0500
Received: from colin.muc.de ([193.149.48.1]:2218 "EHLO mail.muc.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S937663AbWLFV3R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 16:29:17 -0500
Date: 6 Dec 2006 22:29:15 +0100
Date: Wed, 6 Dec 2006 22:29:15 +0100
From: Andi Kleen <ak@muc.de>
To: Kasper Sandberg <lkml@metanurb.dk>
Cc: Chuck Ebbert <76306.1226@compuserve.com>,
       David Howells <dhowells@redhat.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>, vojtech@suse.cz
Subject: Re: BUG? atleast >=2.6.19-rc5, x86 chroot on x86_64
Message-ID: <20061206212915.GA31447@muc.de>
References: <200612052134_MC3-1-D40B-A5DB@compuserve.com> <1165409880.15706.9.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1165409880.15706.9.camel@localhost>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> and i am very very sure its because of this, i can run with the kernel
> (atleast with rc5 i had that long) for 10 days, and then chroot in, run
> the 32bit apps, and within hours of using, hardlock.

Early AMD K8 platforms had a hardware bug that could have caused
such hardlocks when running 32bit code under 64bit (independent of anything 
the kernel does). If you have such a board/CPU try a BIOS update.

-Andi
