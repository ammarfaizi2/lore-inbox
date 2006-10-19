Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422963AbWJSN6W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422963AbWJSN6W (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 09:58:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422981AbWJSN6W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 09:58:22 -0400
Received: from mis011-1.exch011.intermedia.net ([64.78.21.128]:6586 "EHLO
	mis011-1.exch011.intermedia.net") by vger.kernel.org with ESMTP
	id S1422963AbWJSN6V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 09:58:21 -0400
Message-ID: <45378476.4020403@qumranet.com>
Date: Thu, 19 Oct 2006 15:58:14 +0200
From: Avi Kivity <avi@qumranet.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/7] KVM: Kernel-based Virtual Machine
References: <4537818D.4060204@qumranet.com>
In-Reply-To: <4537818D.4060204@qumranet.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 19 Oct 2006 13:58:17.0748 (UTC) FILETIME=[A0E9C540:01C6F386]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Avi Kivity wrote, but forgot to attach the diffstat:
> The following patchset adds a driver for Intel's hardware virtualization
> extensions to the x86 architecture.  The driver adds a character device
> (/dev/kvm) that exposes the virtualization capabilities to userspace.  Using
> this driver, a process can run a virtual machine (a "guest") in a fully
> virtualized PC containing its own virtual hard disks, network adapters, and
> display.
>
>   
[...]

 drivers/Kconfig           |    2
 drivers/Makefile          |    1
 drivers/kvm/Kconfig       |   22
 drivers/kvm/Makefile      |    6
 drivers/kvm/kvm.h         |  387 +++++
 drivers/kvm/kvm_main.c    | 3405
++++++++++++++++++++++++++++++++++++++++++++++
 drivers/kvm/mmu.c         |  718 +++++++++
 drivers/kvm/paging_tmpl.h |  378 +++++
 drivers/kvm/vmx.h         |  287 +++
 drivers/kvm/x86_emulate.c | 1370 ++++++++++++++++++
 drivers/kvm/x86_emulate.h |  185 ++
 include/linux/kvm.h       |  202 ++
 12 files changed, 6963 insertions(+)

-- 
error compiling committee.c: too many arguments to function

