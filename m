Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264001AbTA2E4C>; Tue, 28 Jan 2003 23:56:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264657AbTA2E4C>; Tue, 28 Jan 2003 23:56:02 -0500
Received: from dp.samba.org ([66.70.73.150]:39119 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S264001AbTA2E4A>;
	Tue, 28 Jan 2003 23:56:00 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: colpatch@us.ibm.com
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Cc: William Lee Irwin III <wli@holomorphy.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       Michael Hohnbaum <hohnbaum@us.ibm.com>
Subject: Re: [patch][trivial] fix drivers/base/cpu.c 
In-reply-to: Your message of "Wed, 22 Jan 2003 15:52:33 -0800."
             <3E2F2EC1.4090606@us.ibm.com> 
Date: Wed, 29 Jan 2003 15:51:04 +1100
Message-Id: <20030129050522.316E32C63F@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <3E2F2EC1.4090606@us.ibm.com> you write:
> This is a multi-part message in MIME format.
> --------------050105040306060502000102
> Content-Type: text/plain; charset=us-ascii; format=flowed
> Content-Transfer-Encoding: 7bit
> 
> Both drivers/base/node.c & memblk.c check the return values of the 
> devclass_register & driver_register calls.  cpu.c doesn't.  This little 
> patch remedies that omission.

You'd want to to undo the devclass_register() on failure, too, I
imagine.

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
