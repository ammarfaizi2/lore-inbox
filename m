Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261170AbVDDIeW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261170AbVDDIeW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 04:34:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261175AbVDDIeW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 04:34:22 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:56232 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261170AbVDDIeS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 04:34:18 -0400
Date: Mon, 4 Apr 2005 14:05:07 +0530
From: Prasanna S Panchamukhi <prasanna@in.ibm.com>
To: piotr@slc01.tohoku.grp.ricoh.co.jp, linux-kernel@vger.kernel.org
Cc: Keith Owens <kaos@sgi.com>
Subject: Re: module for controlling kprobes with /proc
Message-ID: <20050404083507.GG1715@in.ibm.com>
Reply-To: prasanna@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Piotr,

Good way to make kprobes useful, but I have some comments.

>I have programmed a universal module to register/remove kprobes handlers
>by interacting with /proc with simple commands.
>

why /proc ?

You can use a combination of SysRq key to enter a kprobe command line prompt.
Initially you can define a dummy breakpoint for command line prompt and accept
commands from thereon.
Later display the list of features add/remove/display breakpoint, backtrace etc.
Also once you hit a breakpoint you give a command line prompt and user can backtrace/ dump some global memory, dump registers etc.

Let me know if you need more information.

Thanks
Prasanna

-- 

Prasanna S Panchamukhi
Linux Technology Center
India Software Labs, IBM Bangalore
Ph: 91-80-25044636
<prasanna@in.ibm.com>
