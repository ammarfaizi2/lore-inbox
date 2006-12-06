Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936424AbWLFQtV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936424AbWLFQtV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 11:49:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936483AbWLFQtU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 11:49:20 -0500
Received: from mx1.redhat.com ([66.187.233.31]:56038 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S936424AbWLFQtT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 11:49:19 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <1165421183.15706.14.camel@localhost> 
References: <1165421183.15706.14.camel@localhost>  <1165409880.15706.9.camel@localhost> <200612052134_MC3-1-D40B-A5DB@compuserve.com> <24125.1165410521@redhat.com> 
To: Kasper Sandberg <lkml@metanurb.dk>
Cc: David Howells <dhowells@redhat.com>,
       Chuck Ebbert <76306.1226@compuserve.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>, ak@muc.de, vojtech@suse.cz
Subject: Re: BUG? atleast >=2.6.19-rc5, x86 chroot on x86_64 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Wed, 06 Dec 2006 16:48:30 +0000
Message-ID: <20057.1165423710@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kasper Sandberg <lkml@metanurb.dk> wrote:

> > What do you mean by "hardlock"?  Do you mean the application has to be killed,
> > or do you mean the kernel is stuck and the machine has to be rebooted?
> i mean the kernel itself, two of the times it has happened to me, magic
> sysrq havent even been able to reboot for me, i had to hit the button on
> my tower.

That's got to be some other problem.  There's no way this ioctl error message
change should cause the kernel to die - applications, yes; but not the kernel.

David
