Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261569AbTI3PLs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 11:11:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261580AbTI3PLs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 11:11:48 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:5896 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id S261569AbTI3PLq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 11:11:46 -0400
Date: Tue, 30 Sep 2003 16:11:23 +0100
From: Dave Jones <davej@redhat.com>
To: Jamie Lokier <jamie@shareable.org>
Cc: John Bradford <john@grabjohn.com>, akpm@osdl.org, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: your mail
Message-ID: <20030930151123.GA16397@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Jamie Lokier <jamie@shareable.org>,
	John Bradford <john@grabjohn.com>, akpm@osdl.org, torvalds@osdl.org,
	linux-kernel@vger.kernel.org
References: <200309300817.h8U8HGrf000881@81-2-122-30.bradfords.org.uk> <20030930133113.GC23333@redhat.com> <200309301410.h8UEAEgJ000652@81-2-122-30.bradfords.org.uk> <20030930145854.GD28876@mail.shareable.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030930145854.GD28876@mail.shareable.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 30, 2003 at 03:58:54PM +0100, Jamie Lokier wrote:

 > (Aside: It is quite an anomaly that those cumbersome floating point
 > instructions are emulated on the older CPUs, yet all the other
 > instructions aren't emulated.  Emulation is very slow, and forcing
 > userspace to just use different code instead is good, but that's just
 > as valid for floating point as it is for MMX, cmpxchg etc.)

There was a patch around a while back that did 486 emulation on 386
kernels. I think it even made into the Mandrake kernel.

 > To be fair, the kernel really ought to just say that and halt.  That
 > is a fine compromise.  It won't make embedded systems folks completely
 > happy, because if you've only got 2MB of NVRAM for your whole kernel
 > _and_ filesystem including user data (think PDA or cellphone), then a
 > hundred bytes here or there is actually worth trimming.

With such tight constraints, why not just use 2.4 (or even 2.2) which
has much lower memory usage and diskspace requirements ?

		Dave

-- 
 Dave Jones     http://www.codemonkey.org.uk
