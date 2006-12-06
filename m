Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937583AbWLFUF5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937583AbWLFUF5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 15:05:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937586AbWLFUF5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 15:05:57 -0500
Received: from pfepc.post.tele.dk ([195.41.46.237]:32993 "EHLO
	pfepc.post.tele.dk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S937583AbWLFUF4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 15:05:56 -0500
Subject: Re: BUG? atleast >=2.6.19-rc5, x86 chroot on x86_64
From: Kasper Sandberg <lkml@metanurb.dk>
To: David Howells <dhowells@redhat.com>
Cc: Chuck Ebbert <76306.1226@compuserve.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>, ak@muc.de, vojtech@suse.cz
In-Reply-To: <20057.1165423710@redhat.com>
References: <1165421183.15706.14.camel@localhost>
	 <1165409880.15706.9.camel@localhost>
	 <200612052134_MC3-1-D40B-A5DB@compuserve.com> <24125.1165410521@redhat.com>
	 <20057.1165423710@redhat.com>
Content-Type: text/plain
Date: Wed, 06 Dec 2006 21:05:41 +0100
Message-Id: <1165435542.31851.3.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-12-06 at 16:48 +0000, David Howells wrote:
> Kasper Sandberg <lkml@metanurb.dk> wrote:
> 
> > > What do you mean by "hardlock"?  Do you mean the application has to be killed,
> > > or do you mean the kernel is stuck and the machine has to be rebooted?
> > i mean the kernel itself, two of the times it has happened to me, magic
> > sysrq havent even been able to reboot for me, i had to hit the button on
> > my tower.
> 
> That's got to be some other problem.  There's no way this ioctl error message
> change should cause the kernel to die - applications, yes; but not the kernel.
Okay, do you have an idea what it can be then? it have to be something
in relation to 32bit emulation, cause it happens only when using 32bit
apps.
> 
> David
> 

