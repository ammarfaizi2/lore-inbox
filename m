Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265125AbSKVDpI>; Thu, 21 Nov 2002 22:45:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265134AbSKVDpI>; Thu, 21 Nov 2002 22:45:08 -0500
Received: from air-2.osdl.org ([65.172.181.6]:13978 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S265125AbSKVDpI>;
	Thu, 21 Nov 2002 22:45:08 -0500
Date: Thu, 21 Nov 2002 19:50:43 -0800 (PST)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: Seiichi Nakashima <nakasima@kumin.ne.jp>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: patch-2.5.48-dj1 compile error
In-Reply-To: <200211220246.AA00001@prism.kumin.ne.jp>
Message-ID: <Pine.LNX.4.33L2.0211211947310.4578-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Nov 2002, Seiichi Nakashima wrote:

| Hi.
|
| I update linux-2.5.48 to use patch-2.5.48-dj1,
| but a patch error and a compile error occured.
|
| (1) patch error
|
| patching file sound/oss/rme96xx.c
| Hunk #3 FAILED at 54.
...
|
| (2) compile error
|
| arch/i386/kernel/apm.c:998: warning: `sysrq_poweroff_op' defined but not used
| fs/proc/array.c: In function `proc_pid_stat':
| fs/proc/array.c:395: warning: long long unsigned int format, different type arg (arg 24)
| make: *** [net] Error 2

Hi,

Did you read the announcement for -dj1?
See:  http://www.lkml.org/archive/2002/11/21/203/index.html

It's not made for applying to plain 2.5.48, and he knows
that there are problems with it.  It's out there so that
others can help decide what needs to go forward and what
doesn't.

-- 
~Randy

