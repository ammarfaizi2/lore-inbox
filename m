Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266552AbTBTRnt>; Thu, 20 Feb 2003 12:43:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266540AbTBTRns>; Thu, 20 Feb 2003 12:43:48 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:59404 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S266408AbTBTRlz>; Thu, 20 Feb 2003 12:41:55 -0500
Date: Thu, 20 Feb 2003 09:48:32 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Jeff Garzik <jgarzik@pobox.com>
cc: Ingo Molnar <mingo@elte.hu>, <linux-kernel@vger.kernel.org>,
       Alex Larsson <alexl@redhat.com>, <procps-list@redhat.com>,
       Alexander Viro <viro@math.psu.edu>
Subject: Re: [patch] procfs/procps threading performance speedup, 2.5.62
In-Reply-To: <20030220172857.GH9800@gtf.org>
Message-ID: <Pine.LNX.4.44.0302200947540.1385-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 20 Feb 2003, Jeff Garzik wrote:
> 
> Having the kernel automatically manage creation/destruction of
> directories is the sticking point, AFAIK.

That _used_ to be an issue, since we didn't actually create the dentry at 
fork time. But we do all that maintenance anyway these days, I think.

		Linus

