Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261817AbVCMKIx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261817AbVCMKIx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Mar 2005 05:08:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263467AbVCMKIx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Mar 2005 05:08:53 -0500
Received: from one.firstfloor.org ([213.235.205.2]:22187 "EHLO
	one.firstfloor.org") by vger.kernel.org with ESMTP id S261817AbVCMKIk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Mar 2005 05:08:40 -0500
To: Mark Studebaker <mds@mds.gotdns.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ancient portmap segfault
References: <4233B520.7010307@mds.gotdns.com>
From: Andi Kleen <ak@muc.de>
Date: Sun, 13 Mar 2005 11:08:38 +0100
In-Reply-To: <4233B520.7010307@mds.gotdns.com> (Mark Studebaker's message of
 "Sat, 12 Mar 2005 22:36:00 -0500")
Message-ID: <m1d5u3yi1l.fsf@muc.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Studebaker <mds@mds.gotdns.com> writes:

> I upgraded from 2.6.5 to 2.6.11.2 and my ancient (libc4 a.out) /sbin/portmap from 1994 that's been running without complaint
> on kernels for 11 years now consistently segfaults.
>
> I upgraded to a version 4 RPM (circa 2002) and that fixed it.
>
> If some compatibility was broken on purpose, that's fine, although I couldn't find anything in the kernel docs.
> I know, I should upgrade everything, but that can break a lot of things too...
> Thought I'd mention it though in case it's a bug or somebody else has the same problem.

It's probably a bug, but your bug report doesn't have enough details
to track it down. Do you have a a.out strace and could send an strace log
with the segfault and the last tens of system calls before it?

-Andi
