Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264403AbTE0Wv0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 18:51:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264416AbTE0Wv0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 18:51:26 -0400
Received: from tomts19-srv.bellnexxia.net ([209.226.175.73]:36846 "EHLO
	tomts19-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S264403AbTE0WvZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 18:51:25 -0400
From: Ed Tomlinson <tomlins@cam.org>
Organization: me
To: Andrew Morton <akpm@digeo.com>
Subject: Re: 2.5.70-mm1
Date: Tue, 27 May 2003 19:05:24 -0400
User-Agent: KMail/1.5.9
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20030527004255.5e32297b.akpm@digeo.com> <200305271633.40421.tomlins@cam.org> <20030527134946.7ffd524d.akpm@digeo.com>
In-Reply-To: <20030527134946.7ffd524d.akpm@digeo.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200305271905.24181.tomlins@cam.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On May 27, 2003 04:49 pm, Andrew Morton wrote:
> Ed Tomlinson <tomlins@cam.org> wrote:
> > Hi Andrew,
> >
> > This one oops on boot 2 out of 3 tries.
> >
> > ...
> > EIP is at load_module+0x7c5/0x800
>
> -mm has modules changes.  Is CONFIG_DEBUG_PAGEALLOC enabled?

#
# Kernel hacking
#
CONFIG_DEBUG_KERNEL=y
CONFIG_DEBUG_STACKOVERFLOW=y
CONFIG_DEBUG_SLAB=y
# CONFIG_DEBUG_IOVIRT is not set
CONFIG_MAGIC_SYSRQ=y
# CONFIG_DEBUG_SPINLOCK is not set
# CONFIG_SPINLINE is not set
# CONFIG_DEBUG_PAGEALLOC is not set
CONFIG_KALLSYMS=y
CONFIG_DEBUG_SPINLOCK_SLEEP=y
# CONFIG_KGDB is not set
CONFIG_DEBUG_INFO=y
CONFIG_FRAME_POINTER=y

No.  I have been running 69-mm8 for several days without problems.   It 
would seem to be an initialization problem, 70-mm1 has now been 3 hours
here.

Ed



