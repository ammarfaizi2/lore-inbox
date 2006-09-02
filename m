Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750791AbWIBBjb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750791AbWIBBjb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 21:39:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750793AbWIBBjb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 21:39:31 -0400
Received: from smtp.osdl.org ([65.172.181.4]:55990 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750791AbWIBBjb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 21:39:31 -0400
Date: Fri, 1 Sep 2006 18:39:27 -0700
From: Andrew Morton <akpm@osdl.org>
To: Grant Coady <gcoady.lk@gmail.com>
Cc: linux-kernel@vger.kernel.org, dmitry.torokhov@gmail.com
Subject: Re: 2.6.18-rc5-mm1
Message-Id: <20060901183927.eba8179d.akpm@osdl.org>
In-Reply-To: <3tkhf2p4f1n1s7ancfmclrlijvne8nhoit@4ax.com>
References: <20060901015818.42767813.akpm@osdl.org>
	<3tkhf2p4f1n1s7ancfmclrlijvne8nhoit@4ax.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 02 Sep 2006 11:06:15 +1000
Grant Coady <gcoady.lk@gmail.com> wrote:

> On Fri, 1 Sep 2006 01:58:18 -0700, Andrew Morton <akpm@osdl.org> wrote:
> 
> >
> >ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc5/2.6.18-rc5-mm1/
> ...
> >- See the `hot-fixes' directory for any important updates to this patchset.
> >
> Okay, I applied hotfixes and it crashed on boot,

There's another hotfix there now:  

ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc5/2.6.18-rc5-mm1/hot-fixes/revert-acpi-mwait-c-state-fixes.patch

If that doesn't prevent the crash, please try to get a trace out of it
somehow?

> keyboard LEDs flashing: Repeating message, hand copied:
> atkbd.c: Spurious ACK in isa0060/serio0. Some program might be trying access 

Yes, one of my machine does that when it crashes too.  It makes the crash
information scroll off the screen in about half a second, which isn't very
kernel-developer-friendly.


-- 
VGER BF report: H 2.94209e-15
