Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264211AbUEXJKz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264211AbUEXJKz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 May 2004 05:10:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264192AbUEXJKR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 May 2004 05:10:17 -0400
Received: from fw.osdl.org ([65.172.181.6]:57284 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264196AbUEXItg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 May 2004 04:49:36 -0400
Date: Mon, 24 May 2004 01:49:01 -0700
From: Andrew Morton <akpm@osdl.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: torvalds@osdl.org, linuxppc64-dev@lists.linuxppc.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dynamic addition of virtual disks on PPC64 iSeries
Message-Id: <20040524014901.04530a24.akpm@osdl.org>
In-Reply-To: <20040524184126.11aeffd3.sfr@canb.auug.org.au>
References: <20040524162039.5f6ca3e0.sfr@canb.auug.org.au>
	<20040523232920.2fb0640a.akpm@osdl.org>
	<20040524184126.11aeffd3.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> On Sun, 23 May 2004 23:29:20 -0700 Andrew Morton <akpm@osdl.org> wrote:
> >
> > Or to generate a hotplug event when a disk is added?  Even if there's no
> > notification to the kernel, it should be possible to generate the hotplug
> > events in response to a /proc-based trigger.
> 
> Of course, it occurs to me that hotplug events must be happening (I guess
> add_disk does it) as udev was quite happily creating hte device nodes for
> me ...

Handy.  So the patch stands as-is?
