Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267180AbTAPQcQ>; Thu, 16 Jan 2003 11:32:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267182AbTAPQcQ>; Thu, 16 Jan 2003 11:32:16 -0500
Received: from cibs9.sns.it ([192.167.206.29]:9744 "EHLO cibs9.sns.it")
	by vger.kernel.org with ESMTP id <S267180AbTAPQcP>;
	Thu, 16 Jan 2003 11:32:15 -0500
Date: Thu, 16 Jan 2003 17:41:02 +0100 (CET)
From: venom@sns.it
To: "Mark H. Wood" <mwood@IUPUI.Edu>
cc: Linux kernel list <linux-kernel@vger.kernel.org>
Subject: Re: The GPL, the kernel, and everything else.
In-Reply-To: <Pine.LNX.4.33.0301161105400.11996-100000@mhw.ULib.IUPUI.Edu>
Message-ID: <Pine.LNX.4.43.0301161737040.28214-100000@cibs9.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Jan 2003, Mark H. Wood wrote:

> Date: Thu, 16 Jan 2003 11:28:42 -0500 (EST)
> From: Mark H. Wood <mwood@IUPUI.Edu>
> To: Linux kernel list <linux-kernel@vger.kernel.org>
> Subject: Re: The GPL, the kernel, and everything else.
>
>
> So, you need to look at the *really* big picture.  There are people who
> think the way you do, and people who don't, and it would be a worthy
> challenge to find a way to somewhat satisfy both groups.
>

please look at this new run queue thing in process context for kernel modules,
and the fact that non GPL modules cannot create an own queue, but have to use
the default one (all queue are managed by a kernel thread).
As you see, for linux 2.6 the big picture will acquire a new element.
(Personally I do like it a lot, as mutch as I like all the run queue approach)

This as quite interesting implications, since it is a penalty for binary only
modules.

Luigi



