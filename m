Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264300AbTKNU6I (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Nov 2003 15:58:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264330AbTKNU6I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Nov 2003 15:58:08 -0500
Received: from modemcable137.219-201-24.mc.videotron.ca ([24.201.219.137]:1664
	"EHLO montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S264300AbTKNU6F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Nov 2003 15:58:05 -0500
Date: Fri, 14 Nov 2003 15:57:06 -0500 (EST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: "Martin J. Bligh" <mbligh@aracnet.com>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: 2.6.0-test9-mm3
In-Reply-To: <3210000.1068786449@[10.10.2.4]>
Message-ID: <Pine.LNX.4.53.0311141555130.27998@montezuma.fsmlabs.com>
References: <20031112233002.436f5d0c.akpm@osdl.org> <3210000.1068786449@[10.10.2.4]>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Nov 2003, Martin J. Bligh wrote:

> > - Several ext2 and ext3 allocator fixes.  These need serious testing on big
> >   SMP.
> 
> Survives kernbench and SDET on ext2 at least on 16-way. I'll try ext3
> later.

It's actually triple faulting my laptop (K6 family=5 model=8 step=12) when 
i have CONFIG_X86_4G enabled and try and run X11. The same kernel is fine 
on all my other test boxes. Any hints?
