Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932469AbVKQTBd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932469AbVKQTBd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 14:01:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932475AbVKQTBd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 14:01:33 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:13252 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S932469AbVKQTBd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 14:01:33 -0500
Message-ID: <1132254076.437cd37c713fd@imap.linux.ibm.com>
Date: Thu, 17 Nov 2005 14:01:16 -0500
From: Maneesh Soni <maneesh@in.ibm.com>
To: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, "Brown, Len" <len.brown@intel.com>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Subject: RE: maxcpus=1 broken, ACPI bug?
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.7
X-Originating-IP: 9.182.62.236
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>:

> 
> Hi,
> 
> I am not yet able to see how this patch can cause a hang like that. My
> initial guess is that it has got something to with idle routine and
> preempt. I will look more into this and try to reproduce it locally. Can
> you please try out disable preemption in your config and try 2.6.15-rc1
> and let me know how it goes.
 
Hi Venki,

Thanks for looking into this. I tried 2.6.15-rc1 with CONFIG_PREEMPT_NONE=y 
but still it hangs in the same way.

Thanks
Maneesh

-- 
Maneesh Soni
IBM Linux Technology Center
IBM India Software Labs,
Bangalore, India
Ph. 91-80-25044990
email: maneesh@in.ibm.com
