Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261366AbVEGAdT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261366AbVEGAdT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 May 2005 20:33:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261367AbVEGAdS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 May 2005 20:33:18 -0400
Received: from fire.osdl.org ([65.172.181.4]:18148 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261366AbVEGAcv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 May 2005 20:32:51 -0400
Date: Fri, 6 May 2005 17:32:11 -0700
From: Andrew Morton <akpm@osdl.org>
To: Gerrit Huizenga <gh@us.ibm.com>
Cc: sharada@in.ibm.com, paulus@samba.org, torvalds@osdl.org, anton@samba.org,
       linux-kernel@vger.kernel.org, miltonm@bga.com, fastboot@lists.osdl.org
Subject: Re: [PATCH] ppc64: kexec support for ppc64
Message-Id: <20050506173211.0bc2db7e.akpm@osdl.org>
In-Reply-To: <E1DUCQS-0005Sq-00@w-gerrit.beaverton.ibm.com>
References: <20050506160546.388aeed4.akpm@osdl.org>
	<E1DUCQS-0005Sq-00@w-gerrit.beaverton.ibm.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gerrit Huizenga <gh@us.ibm.com> wrote:
>
> [ ... ]
>

But you didn't address the question of whether the kexec feature is
sufficiently useful in its own right to justify merging.

> 
>   If it takes a little list or test matrix of platforms tested over the
>   short term to help verify what machines work, we might be able to set
>   something like that up as well.

Yes, please do that.  But remember that Linux has a distributed test team
of thousands.  I have a separate proposal:

My big checkbox for kdump is "can I personally use kdump to diagnose and
solve testers' bug reports?".

If we can reach the stage where a random person downloads a -mm kernel,
hits a bug and, with a reasonable success rate, can send me a kernel core
file which I find useful then yeah, it's proven.

Problem is, I haven't gotten around to moving this idea an inch forward and
am unlikely to do so.

It would really help if some of the kdump developers could assist: make
sure the instructions are easy, that the tools are available, work with
people on the mailing list to get a core file from them, then, using the
core file, work with the relevant maintainer to identify and solve the bug.
We did this a few weeks ago with the -mm timer deadlock.  Off-list, I think.

Possible?
