Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266957AbTADPjY>; Sat, 4 Jan 2003 10:39:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266964AbTADPjY>; Sat, 4 Jan 2003 10:39:24 -0500
Received: from main.gmane.org ([80.91.224.249]:19400 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id <S266957AbTADPjX>;
	Sat, 4 Jan 2003 10:39:23 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: "Steven Barnhart" <sbarn03@softhome.net>
Subject: Re: 2.5.54-mm3
Date: Sat, 04 Jan 2003 10:47:46 -0500
Message-ID: <pan.2003.01.04.15.47.43.915841@softhome.net>
References: <3E16A2B6.A741AE17@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
X-Complaints-To: usenet@main.gmane.org
User-Agent: Pan/0.13.0 (The whole remains beautiful)
Cc: linux-mm@kvack.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 04 Jan 2003 01:00:38 +0000, Andrew Morton wrote:

> Filesystem mount and unmount is a problem.  Probably, this will not be
> addressed.  People who have specialised latency requirements should avoid
> using automounters and those gadgets which poll CDROMs for insertion events.

That stinks...it don't work in .54 and I'd likem to have my automounter
functioning again. Oh well it *is* 2.5.

> This work has broken the shared pagetable patch - it touches the same code
> in many places.   I shall put Humpty together again, but will not be 
> including it for some time.  This is because there may be bugs in this
> patch series which are accidentally fixed in the shared pagetable patch. So
> shared pagetables will be reintegrated when these changes have had sufficient
> testing.

Also for some reason I always have to do a "touch /fastboot" and boot in
rw mode to boot the kernel. The kernel fails on remouting fs in r-w mode.
X also don't work saying /dev/agpgart don't exist even though it does and
I saw it. agpgart module is loaded..maybe it would work as built into the
kernel? .config attached.

Steven


