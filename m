Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290306AbSBKUUh>; Mon, 11 Feb 2002 15:20:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290309AbSBKUU1>; Mon, 11 Feb 2002 15:20:27 -0500
Received: from zero.tech9.net ([209.61.188.187]:5124 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S290306AbSBKUUK>;
	Mon, 11 Feb 2002 15:20:10 -0500
Subject: Re: thread_info implementation
From: Robert Love <rml@tech9.net>
To: Arkadiy Chapkis - Arc <achapkis@mail.dls.net>
Cc: LINUX-KERNEL@vger.kernel.org
In-Reply-To: <00A09679.2A996F5D.164@mail.dls.net>
In-Reply-To: <00A09679.2A996F5D.164@mail.dls.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 11 Feb 2002 15:19:27 -0500
Message-Id: <1013458767.6785.459.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-02-11 at 12:39, Arkadiy Chapkis - Arc wrote:

> In file included from
> /usr/local/src/test/linux-2.5.4/include/linux/spinlock.h:7,
>                  from
> /usr/local/src/test/linux-2.5.4/include/linux/module.h:11,
>                  from loop.c:55:
> /usr/local/src/test/linux-2.5.4/include/linux/thread_info.h:10:29:
> asm/thread_info.h: No such file or directory

This is known.  I don't believe any arches except i386 and SPARC64 are
using the new thread_info / task_struct implementation introduced during
2.5.4-pre.

I think I saw some changesets from Jeff Garzik wrt alpha thread_info
support, so perhaps in 2.5.5-pre1.

	Robert Love

