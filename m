Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936313AbWLFQGf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936313AbWLFQGf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 11:06:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936317AbWLFQGf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 11:06:35 -0500
Received: from pfepa.post.tele.dk ([195.41.46.235]:53446 "EHLO
	pfepa.post.tele.dk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936313AbWLFQGe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 11:06:34 -0500
Subject: Re: BUG? atleast >=2.6.19-rc5, x86 chroot on x86_64
From: Kasper Sandberg <lkml@metanurb.dk>
To: David Howells <dhowells@redhat.com>
Cc: Chuck Ebbert <76306.1226@compuserve.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>, ak@muc.de, vojtech@suse.cz
In-Reply-To: <24125.1165410521@redhat.com>
References: <1165409880.15706.9.camel@localhost>
	 <200612052134_MC3-1-D40B-A5DB@compuserve.com> <24125.1165410521@redhat.com>
Content-Type: text/plain
Date: Wed, 06 Dec 2006 17:06:23 +0100
Message-Id: <1165421183.15706.14.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-12-06 at 13:08 +0000, David Howells wrote:
> Kasper Sandberg <lkml@metanurb.dk> wrote:
> 
> > and i am very very sure its because of this, i can run with the kernel
> > (atleast with rc5 i had that long) for 10 days, and then chroot in, run
> > the 32bit apps, and within hours of using, hardlock.
> 
> What do you mean by "hardlock"?  Do you mean the application has to be killed,
> or do you mean the kernel is stuck and the machine has to be rebooted?
i mean the kernel itself, two of the times it has happened to me, magic
sysrq havent even been able to reboot for me, i had to hit the button on
my tower.

when i the very first time encountered this, it was with regedit, the
app went nuts, and then it frooze, i had to kill -9 it, and then an hour
later i noticed the kernel messages.
> 
> David
> 

