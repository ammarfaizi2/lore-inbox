Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265535AbUAPTaK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 14:30:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265507AbUAPTaK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 14:30:10 -0500
Received: from chaos.analogic.com ([204.178.40.224]:57475 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S265701AbUAPTaG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 14:30:06 -0500
Date: Fri, 16 Jan 2004 14:32:39 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: cliff white <cliffw@osdl.org>
cc: Adrian Bunk <bunk@fs.tum.de>, piggin@cyberone.com.au, mpm@selenic.com,
       linux-kernel@vger.kernel.org
Subject: Re: [1/4] better i386 CPU selection
In-Reply-To: <20040116111501.70200cf3.cliffw@osdl.org>
Message-ID: <Pine.LNX.4.53.0401161425110.31018@chaos>
References: <20040106054859.GA18208@waste.org> <3FFA56D6.6040808@cyberone.com.au>
 <20040106064607.GB18208@waste.org> <3FFA5ED3.6040000@cyberone.com.au>
 <20040110004625.GB25089@fs.tum.de> <20040110005232.GD25089@fs.tum.de>
 <20040116111501.70200cf3.cliffw@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Jan 2004, cliff white wrote:

> On Sat, 10 Jan 2004 01:52:32 +0100
> Adrian Bunk <bunk@fs.tum.de> wrote:
>
>
> > Changes:

> > - AMD Elan is a different subarch, you can't configure a kernel that
> >   runs on both the AMD Elan and other i386 CPUs

NO! NO!  This prevents development of an AMD embeded system on an
"ordinary" machine like this one (Pentium IV). The fact that the
timer runs at a different speed means nothing, one just sets the
workstation time every day. Please do NOT do this. It prevents
important usage.

> > - added optimizing CFLAGS for the AMD Elan

There are no such different "optimizations" for ELAN.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.24 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


