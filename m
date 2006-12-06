Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1760579AbWLFNJj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760579AbWLFNJj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 08:09:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760582AbWLFNJj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 08:09:39 -0500
Received: from mx1.redhat.com ([66.187.233.31]:46377 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760585AbWLFNJi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 08:09:38 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <1165409880.15706.9.camel@localhost> 
References: <1165409880.15706.9.camel@localhost>  <200612052134_MC3-1-D40B-A5DB@compuserve.com> 
To: Kasper Sandberg <lkml@metanurb.dk>
Cc: Chuck Ebbert <76306.1226@compuserve.com>,
       David Howells <dhowells@redhat.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>, ak@muc.de, vojtech@suse.cz
Subject: Re: BUG? atleast >=2.6.19-rc5, x86 chroot on x86_64 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Wed, 06 Dec 2006 13:08:41 +0000
Message-ID: <24125.1165410521@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kasper Sandberg <lkml@metanurb.dk> wrote:

> and i am very very sure its because of this, i can run with the kernel
> (atleast with rc5 i had that long) for 10 days, and then chroot in, run
> the 32bit apps, and within hours of using, hardlock.

What do you mean by "hardlock"?  Do you mean the application has to be killed,
or do you mean the kernel is stuck and the machine has to be rebooted?

David
