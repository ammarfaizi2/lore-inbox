Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751753AbWF1XCP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751753AbWF1XCP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 19:02:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751757AbWF1XCP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 19:02:15 -0400
Received: from smtp.osdl.org ([65.172.181.4]:49089 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751753AbWF1XCO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 19:02:14 -0400
Date: Wed, 28 Jun 2006 16:02:06 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Wim Van Sebroeck <wim@iguana.be>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [WATCHDOG] v2.6.17 watchdog patches
In-Reply-To: <20060628193145.GA2738@infomag.infomag.iguana.be>
Message-ID: <Pine.LNX.4.64.0606281600300.12404@g5.osdl.org>
References: <20060628193145.GA2738@infomag.infomag.iguana.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 28 Jun 2006, Wim Van Sebroeck wrote:
> 
> Please pull from 'master' branch of
> 	rsync://rsync.kernel.org/pub/scm/linux/kernel/git/wim/linux-2.6-watchdog.git
> or if master.kernel.org hasn't synced up yet:
> 	master.kernel.org:/pub/scm/linux/kernel/git/wim/linux-2.6-watchdog.git

Btw, you're apparently not signing off on the patches as you apply them to 
your tree.

It looks like the sequence up to you is properly signed off, but you 
should close it off to make the committer field match the whole sign-off 
chain:

> Author: Randy Dunlap <rdunlap@xenotime.net>
> Date:   Sun May 21 20:58:10 2006 -0700
> 
>     [WATCHDOG] Documentation/watchdog update
>     
>     Documentation/watchdog/:
>     Expose example and tool source files in the Documentation/ directory in
>     their own files instead of being buried (almost hidden) in readme/txt files.
>     
>     This will make them more visible/usable to users who may need
>     to use them, to developers who may need to test with them, and
>     to janitors who would update them if they were more visible.
>     
>     Also, if any of these possibly should not be in the kernel tree at
>     all, it will be clearer that they are here and we can discuss if
>     they should be removed.
>     
>     Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
>     Signed-off-by: Wim Van Sebroeck <wim@iguana.be>
>     Signed-off-by: Andrew Morton <akpm@osdl.org>

It went from Randy to Win to Andrew and then to you, but your sign-off is 
missing..

		Linus
