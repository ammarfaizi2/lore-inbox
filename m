Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751200AbWGLNxc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751200AbWGLNxc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 09:53:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751371AbWGLNxc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 09:53:32 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:18346 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751200AbWGLNxb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 09:53:31 -0400
Subject: Re: PATCH: Minimal fix for sysrq on serial console hang
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <20060712134749.GA11047@flint.arm.linux.org.uk>
References: <1152712461.22943.58.camel@localhost.localdomain>
	 <20060712134749.GA11047@flint.arm.linux.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 12 Jul 2006 15:11:31 +0100
Message-Id: <1152713491.22943.72.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Mer, 2006-07-12 am 14:47 +0100, ysgrifennodd Russell King:
> On Wed, Jul 12, 2006 at 02:54:21PM +0100, Alan Cox wrote:
> > When I originally did this change I used oops_in_progress as a locking
> > guide. However it turns out there is one other place that turns all the
> > locking on its head and that is sysrq.
> 
> Well, akpm's had a fix in his tree for some time, which he's been
> pestering me with, so I committed that a few days ago:


Even better, thanks hadn't seen that go in.

