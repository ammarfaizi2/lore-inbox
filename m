Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261884AbUKCVLZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261884AbUKCVLZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 16:11:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261879AbUKCVHt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 16:07:49 -0500
Received: from mail-relay-1.tiscali.it ([213.205.33.41]:24192 "EHLO
	mail-relay-1.tiscali.it") by vger.kernel.org with ESMTP
	id S261878AbUKCVFU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 16:05:20 -0500
From: Lorenzo Allegrucci <l_allegrucci@yahoo.it>
Organization: -ENOENT
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc1-mm2-V0.7.1
Date: Wed, 3 Nov 2004 22:05:18 +0100
User-Agent: KMail/1.7
Cc: linux-kernel@vger.kernel.org
References: <20041018145008.GA25707@elte.hu> <200411032141.05571.l_allegrucci@yahoo.it> <20041103204352.GA855@elte.hu>
In-Reply-To: <20041103204352.GA855@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411032205.18113.l_allegrucci@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 03 November 2004 21:43, Ingo Molnar wrote:
> 
> * Lorenzo Allegrucci <l_allegrucci@yahoo.it> wrote:
> 
> > On Wednesday 03 November 2004 18:53, Lorenzo Allegrucci wrote:
> > > On Wednesday 03 November 2004 14:46, Ingo Molnar wrote:
> > > > 
> > > > * Lorenzo Allegrucci <l_allegrucci@yahoo.it> wrote:
> > > > 
> > > > >   LD      init/built-in.o
> > > > >   LD      .tmp_vmlinux1
> > > > > net/built-in.o(.text+0x1887f): In function `netpoll_setup':
> > > > > : undefined reference to `rcu_read_lock_up_read'
> > > > > net/built-in.o(.text+0x188ed): In function `netpoll_setup':
> > > > > : undefined reference to `rcu_read_lock_up_read'
> > > > > make: *** [.tmp_vmlinux1] Error 1
> > > > 
> > > > fixed in -V0.7.3.
> > > 
> > > I've just tried V0.7.3 but my PS/2 mouse and keyboard don't work.
> > > No message from the kernel.  I attach my .config
> > 
> > Problem solved disabling ACPI.
> 
> does the same problem happen in vanilla 2.6.10-rc1-mm2 too?

No it doesn't.

-- 
I route therefore you are
