Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264707AbUD2OzY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264707AbUD2OzY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 10:55:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264733AbUD2OzY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 10:55:24 -0400
Received: from pointyears.net ([66.92.166.101]:11088 "EHLO tux.pointyears.net")
	by vger.kernel.org with ESMTP id S264707AbUD2OzQ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 10:55:16 -0400
Date: Thu, 29 Apr 2004 10:55:01 -0400
From: Rick Zeman <rzeman@pointyears.net>
Subject: Re: [PATCH] Blacklist binary-only modules lying about their license
To: lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Priority: 3
Message-ID: <r02010100-1033-3187424699ED11D891F1003065B6303C@[192.168.1.130]>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
X-Mailer: Mailsmith 2.1.1 (Blindsider)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/28/04 at 8:02 PM (GMT-0400), Rik van Riel <riel@redhat.com> wrote:

>I wouldn't be averse to changing the text the kernel prints
>when loading a module with an incompatible license. If the
>text "$MOD_FOO: module license '$BLAH' taints kernel." upsets
>the users, it's easy enough to change it.
>
>How about the following?
>
>"Due to $MOD_FOO's license ($BLAH), the Linux kernel community
>cannot resolve problems you may encounter. Please contact
>$MODULE_VENDOR for support issues."

That's too sensible:  Linux wouldn't be Linux without incomprehensible
messages like:

$ sudo urpmi /home/rzeman/kernel-smp-2.4.25.4mdk-1-1mdk.i586.rpm 

installing /home/rzeman/kernel-smp-2.4.25.4mdk-1-1mdk.i586.rpm
Preparing...
##################################################
   1:kernel-smp-2.4.25.4mdk
##################################################
look like there was a problem, the default vmlinuz version is not the same 
of the initrd which mean you have a mdk kernel and not a mdk initrd you may
go in trouble

or doing a menuconfig on a new 2.4.26 kernel and having it nicely tell me
that my choice HAD to be a module, not built in, because it depends upon
something else already selected as a module--without bothering to deign to
say what the dependency was so I had to play grand guessing games.

/this week's irritations.

--
Mac OS X: Because making UNIX user-friendly was easier than fixing Windows.
