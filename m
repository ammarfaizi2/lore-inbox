Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266183AbUHAVr7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266183AbUHAVr7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Aug 2004 17:47:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266185AbUHAVr7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Aug 2004 17:47:59 -0400
Received: from the-village.bc.nu ([81.2.110.252]:20144 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S266183AbUHAVr6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Aug 2004 17:47:58 -0400
Subject: Re: secure computing for 2.6.7
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: chris@scary.beasts.org
Cc: Andrea Arcangeli <andrea@cpushare.com>, Hans Reiser <reiser@namesys.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0408011801260.1368@sphinx.mythic-beasts.com>
References: <20040704173903.GE7281@dualathlon.random>
	 <40EC4E96.9090800@namesys.com> <20040801102231.GB6295@dualathlon.random>
	 <Pine.LNX.4.58.0408011248040.1368@sphinx.mythic-beasts.com>
	 <20040801150119.GE6295@dualathlon.random>
	 <Pine.LNX.4.58.0408011801260.1368@sphinx.mythic-beasts.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1091393114.31139.5.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sun, 01 Aug 2004 21:45:14 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2004-08-01 at 18:29, chris@scary.beasts.org wrote:
> How hard would it be to have a per-task bitmap of syscalls allowed? This
> way, a task could restrict to the exact subset of syscalls required for
> maximum security.

Very easy indeed, although you might have to do a tiny bit of tweaking
for kernel made syscalls (eg hotplug triggers).

You can already do all of this using several user space applications
that manage it via ptrace. They do have a performance hit however.

