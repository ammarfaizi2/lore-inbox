Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265893AbUHAMBU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265893AbUHAMBU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Aug 2004 08:01:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265897AbUHAMBT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Aug 2004 08:01:19 -0400
Received: from sphinx.mythic-beasts.com ([212.69.37.6]:29828 "EHLO
	sphinx.mythic-beasts.com") by vger.kernel.org with ESMTP
	id S265893AbUHAMBS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Aug 2004 08:01:18 -0400
Date: Sun, 1 Aug 2004 13:01:10 +0100 (BST)
From: chris@scary.beasts.org
X-X-Sender: cevans@sphinx.mythic-beasts.com
To: Andrea Arcangeli <andrea@cpushare.com>
cc: Hans Reiser <reiser@namesys.com>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: secure computing for 2.6.7
In-Reply-To: <20040801102231.GB6295@dualathlon.random>
Message-ID: <Pine.LNX.4.58.0408011248040.1368@sphinx.mythic-beasts.com>
References: <20040704173903.GE7281@dualathlon.random> <40EC4E96.9090800@namesys.com>
 <20040801102231.GB6295@dualathlon.random>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 1 Aug 2004, Andrea Arcangeli wrote:

> sounds like yes. However what I'm doing with the seccomp [2] mode is
> much order of magnitude simpler and less generic, so I don't expect it
> will be useful to many apps. When you mention in your document that

Hi Andrea,

Do you have plans to generalize seccomp into somelike like a "syscall
firewall"? This _would_ be useful to many apps, and provide good security
benefits - for example, vsftpd does not need most of the previously-buggy
syscalls such as sysctl(), mremap() and execve(). But it does need more
than just read(), write() and exit()!

Cheers
Chris
