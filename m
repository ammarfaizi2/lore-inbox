Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751302AbWJARGZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751302AbWJARGZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Oct 2006 13:06:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751304AbWJARGZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Oct 2006 13:06:25 -0400
Received: from xenotime.net ([66.160.160.81]:1498 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751302AbWJARGY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Oct 2006 13:06:24 -0400
Date: Sun, 1 Oct 2006 10:07:47 -0700
From: Randy Dunlap <rdunlap@xenotime.net>
To: Jeff Garzik <jeff@garzik.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: Announce: gcc bogus warning repository
Message-Id: <20061001100747.d1842273.rdunlap@xenotime.net>
In-Reply-To: <451FC657.6090603@garzik.org>
References: <451FC657.6090603@garzik.org>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 01 Oct 2006 09:44:55 -0400 Jeff Garzik wrote:

> 
> The level of warnings in a kernel build has lately increased to the 
> point where it is hiding bugs and otherwise making life difficult.
> 
> In particular, recent gcc versions throw warnings when it thinks a 
> variable "MAY be used uninitialized", which is not terribly helpful due 
> to the fact that most of these warnings are bogus.
> 
> For those that may find this valuable, I have started a git repo that 
> silences these bogus warnings, after careful auditing of code paths to 
> ensure that the warning truly is bogus.
> 
> The results may be found in the "gccbug" branch of
> git://git.kernel.org/pub/scm/linux/kernel/git/jgarzik/misc-2.6.git
> 
> This repository will NEVER EVER be pushed upstream.  It exists solely 
> for those who want to decrease their build noise, thereby exposing true 
> bugs.
> 
> The audit has already uncovered several minor bugs, lending credence to 
> my theory that too many warnings hides bugs.

I usually build with must_check etc. enabled then grep them
away if I want to look for other messages.  I think that the situation
is not so disastrous.

---
~Randy
