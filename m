Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262500AbSLURvr>; Sat, 21 Dec 2002 12:51:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262783AbSLURvr>; Sat, 21 Dec 2002 12:51:47 -0500
Received: from [81.2.122.30] ([81.2.122.30]:54532 "EHLO darkstar.example.net")
	by vger.kernel.org with ESMTP id <S262500AbSLURvq>;
	Sat, 21 Dec 2002 12:51:46 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200212211811.gBLIBeX9000864@darkstar.example.net>
Subject: Re: Kernel GCC Optimizations
To: lkml@ro0tsiege.org (Ro0tSiEgE)
Date: Sat, 21 Dec 2002 18:11:39 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200212211135.10289.lkml@ro0tsiege.org> from "Ro0tSiEgE" at Dec 21, 2002 11:35:10 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Is there any risk using -O3 instead of -O2 to compile the kernel, and why?

* It might uncover subtle bugs that would otherwise not occur.

* Compiling with unusual options means that less people will know about
any problems it causes you.

>  Also what about compiling against glibc 2.3.1 and gcc 3.2.x??

The kernel does not use glibc functions, so you can compile the kernel
and glibc with different compilers.

Bug reports about GCC 3.2.x compiled kernels will probably be welcomed
by most developers.

John.
