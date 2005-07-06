Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261381AbVGFHRy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261381AbVGFHRy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 03:17:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262128AbVGFHRh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 03:17:37 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:18835 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S262124AbVGFF65
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 01:58:57 -0400
Date: Wed, 6 Jul 2005 11:29:35 +0530
From: Prasanna S Panchamukhi <prasanna@in.ibm.com>
To: Jeff Carr <jcarr@linuxmachines.com>
Cc: linux-kernel@vger.kernel.org, Hien Nguyen <hien@us.ibm.com>,
       Jim Keniston <jkenisto@us.ibm.com>
Subject: Re: kprobe support for memory access watchpoints
Message-ID: <20050706055935.GB22093@in.ibm.com>
Reply-To: prasanna@in.ibm.com
References: <42CAB369.5020901@linuxmachines.com> <42CAFF09.4000406@linuxmachines.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42CAFF09.4000406@linuxmachines.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff,

> I was wondering if there are plans to support a method to register
> watchpoints for memory data access with kprobe. On x86, it's possible to
> watch for read/write access to arbitrary memory locations via DR memory
> registers.

Here are couple of patches providing debug register allocation
mechanism and kernel API to register watchpoints. These patches were
posted and reviewed on lkml some time back, Please see the URL
below for details.

http://seclists.org/lists/linux-kernel/2004/Oct/4730.html
http://seclists.org/lists/linux-kernel/2004/Oct/4729.html


Thanks
Prasanna
-- 

Prasanna S Panchamukhi
Linux Technology Center
India Software Labs, IBM Bangalore
Ph: 91-80-25044636
<prasanna@in.ibm.com>
