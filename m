Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264037AbSKDAgS>; Sun, 3 Nov 2002 19:36:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264146AbSKDAgS>; Sun, 3 Nov 2002 19:36:18 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:64920 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S264037AbSKDAgR>; Sun, 3 Nov 2002 19:36:17 -0500
Date: Sun, 3 Nov 2002 19:42:49 -0500
From: Pete Zaitcev <zaitcev@redhat.com>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Pete Zaitcev <zaitcev@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: interrupt checks for spinlocks
Message-ID: <20021103194249.A1603@devserv.devel.redhat.com>
References: <mailman.1036362421.16883.linux-kernel2news@redhat.com> <200211040028.gA40S8600593@devserv.devel.redhat.com> <20021104002813.GZ16347@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021104002813.GZ16347@holomorphy.com>; from wli@holomorphy.com on Sun, Nov 03, 2002 at 04:28:13PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Date: Sun, 3 Nov 2002 16:28:13 -0800
> From: William Lee Irwin III <wli@holomorphy.com>

> >> (1) check that spinlocks are not taken in interrupt context without
> >> 	interrupts disabled

> > Bill, why is this bad? I routinely use this technique.
> > -- Pete
> 
> If you receive the same interrupt on the same cpu and re-enter code
> that does that, you will deadlock.

How would that happen? I thought it was not possible to re-enter
an interrupt, and that it was pretty fundamental for Linux.
When did we allow it, and what are implications for architectures?

-- Pete
