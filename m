Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261752AbTIYS5b (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 14:57:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261820AbTIYS5a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 14:57:30 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:20990 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261752AbTIYS53 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 14:57:29 -0400
Date: Thu, 25 Sep 2003 09:51:29 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org, akpm@digeo.com
Subject: Re: ext3 panic on test4 running dbench
Message-ID: <25380000.1064508689@flay>
In-Reply-To: <20030925114404.4e30a8d4.akpm@osdl.org>
References: <20610000.1064504990@flay> <20030925114404.4e30a8d4.akpm@osdl.org>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Sep 24 02:26:14 elm3b67 kernel: invalid operand: 0000 [#1]
>> Sep 24 02:26:14 elm3b67 kernel: CPU:    11
>> Sep 24 02:26:14 elm3b67 kernel: EIP:    0060:[_end+404081921/1069412752]    Not tainted
>> Sep 24 02:26:14 elm3b67 kernel: EFLAGS: 00010206
>> Sep 24 02:26:14 elm3b67 kernel: EIP is at 0xd857bb71
> 
> Your EIP looks like it is in modules space.

I never use modules. Yes, that's ... odd.
 
> But syslogd has conveniently gone and futzed with the oops trace so I
> cannot tell what address your ext3 driver was loaded at.  Sigh.  Please add
> `-x' to your syslogd invokation and shoot whoever first thought of this.

Pah. OK, will retry. Or I'll stick a serial console back on and working
next week when I'm back in the office.

M.

 


