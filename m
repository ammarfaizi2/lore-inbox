Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261159AbTEERtm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 13:49:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261162AbTEERtl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 13:49:41 -0400
Received: from mailrelay2.lanl.gov ([128.165.4.103]:19627 "EHLO
	mailrelay2.lanl.gov") by vger.kernel.org with ESMTP id S261159AbTEERtk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 13:49:40 -0400
Subject: Re: Kernel hot-swap using Kexec, BProc and CC/SMP Clusters.
From: Steven Cole <elenstev@mesatop.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-kernel@vger.kernel.org, Larry McVoy <lm@bitmover.com>,
       Linus Torvalds <torvalds@transmeta.com>
In-Reply-To: <m1d6ixb8m7.fsf@frodo.biederman.org>
References: <1052140733.2163.93.camel@spc9.esa.lanl.gov>
	 <m1d6ixb8m7.fsf@frodo.biederman.org>
Content-Type: text/plain
Organization: 
Message-Id: <1052157615.2163.113.camel@spc9.esa.lanl.gov>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4-1.1mdk 
Date: 05 May 2003 12:00:15 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-05-05 at 11:34, Eric W. Biederman wrote:
> So summarize:
> 1) Run multiple kernels (minimally kernels A and B)
> 2) Migrate processes from kernel A to kernel B
> 3) Use kexec to replace kernel A once all processes have left.
> 4) Repeat for all other kernels.
> 
> On two simple machines working in tandem (The most common variation
> used for high availability this should be easy to do).  And it is
> preferable to a reboot because of the additional control and speed.
> 
> Thank you for the perspective.  This looks like I line I can
> sell to get some official time to work on kexec and it's friends
> more actively.

Cutting boot time in half is pretty good as it is right now.

> 
> >From what I have seen process migration/process check-pointing is
> currently the very rough area.
> 
> The interesting thing becomes how do you measure system uptime.
> 
> Eric

Perhaps two uptimes could be kept. The current concept of uptime would
remain as is, analogous to the reign of a king (the current kernel), and
a new integrated uptime would be analogous to the life of a dynasty. The
dynasty uptime would be one of the many things the new kernel learned
about on booting. This new dynasty uptime could become quite long if
everything keeps on ticking.

Steven

