Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261929AbUAIPUm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jan 2004 10:20:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261931AbUAIPUl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jan 2004 10:20:41 -0500
Received: from mail.gmx.net ([213.165.64.20]:22204 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261929AbUAIPUW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jan 2004 10:20:22 -0500
X-Authenticated: #20450766
Date: Fri, 9 Jan 2004 16:18:43 +0100 (CET)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: Wakko Warner <wakko@animx.eu.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: Strange lockup with 2.6.0
In-Reply-To: <20040109093913.A6710@animx.eu.org>
Message-ID: <Pine.LNX.4.44.0401091607050.7051-100000@poirot.grange>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Jan 2004, Wakko Warner wrote:

> I usually do a backup of each filesystem simply using tar.  I attempted to
> backup a machine I had that's running 2.6.0 and it hard locked.

Are sysrq-keys enabled? If so, could you catch the tar backtrace during
the lock-up (ALT-SysRq-t)? What was the latest kernel-version that worked?
Can you just try to write some data over NFS? Would it lock if you write 1
byte or 1K or 1M? Does it lock immediately as you start the backup or
after some time (you could start some process in the background
periodically printing some info on the terminal, like vmstat, cat
/proc/interrupts, free, tcpdump on both ends to a file...) Can you try NFS
over TCP? Are other machines, where backup works, also running 2.6,
10/100mbps?

Guennadi
---
Guennadi Liakhovetski


