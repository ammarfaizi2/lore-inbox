Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262453AbUCCQlJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 11:41:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262511AbUCCQlJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 11:41:09 -0500
Received: from mail1.fw-sj.sony.com ([160.33.82.68]:49342 "EHLO
	mail1.fw-sj.sony.com") by vger.kernel.org with ESMTP
	id S262485AbUCCQlG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 11:41:06 -0500
Message-ID: <40460C8E.4010100@am.sony.com>
Date: Wed, 03 Mar 2004 08:49:18 -0800
From: Tim Bird <tim.bird@am.sony.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.4) Gecko/20030624 Netscape/7.1 (ax)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Billy Rose <billyrose@cox-internet.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: kernel mode console
References: <200403022152.06950.billyrose@cox-internet.com>
In-Reply-To: <200403022152.06950.billyrose@cox-internet.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Billy Rose wrote:
> i have some bandwidth i can dedicate to writting a kernel module that provides 
> a command interpreter running in kernel space (think of it as the god mode 
> console in quake). the purpose for this would be primarily aimed at the 
> kernel developers so they can reach in and grab variables, dump certain 
> sections of memory, walk memory, dump code segments, dump processes 
> (including the kernel data structures for them), anything else i/you can 
> think of. is this a waste of time, or would that get used?

I think it would be valuable, especially for embedded developers
when they have trouble getting user space up on a new platform.
Also, it could be something simple and solid.  It's a pain to
set up a remote debug session just to poke around in the kernel.
Remote debug setup is complex and often fragile.

I'd be willing to test this if you get something running, and
give you some feedback.  For me, it would be best if the module
could be statically linked.

How do you plan to handle symbolic information?

=============================
Tim Bird
Architecture Group Co-Chair
CE Linux Forum
Senior Staff Engineer
Sony Electronics
E-mail: Tim.Bird@am.sony.com
=============================

