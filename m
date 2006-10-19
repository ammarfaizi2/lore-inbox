Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946152AbWJSQFW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946152AbWJSQFW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 12:05:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946153AbWJSQFW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 12:05:22 -0400
Received: from cantor2.suse.de ([195.135.220.15]:64427 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1946152AbWJSQFV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 12:05:21 -0400
To: Avi Kivity <avi@qumranet.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/7] KVM: Kernel-based Virtual Machine
References: <4537818D.4060204@qumranet.com>
From: Andi Kleen <ak@suse.de>
Date: 19 Oct 2006 18:05:03 +0200
In-Reply-To: <4537818D.4060204@qumranet.com>
Message-ID: <p73lkncb8b4.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Avi Kivity <avi@qumranet.com> writes:

> The following patchset adds a driver for Intel's hardware virtualization
> extensions to the x86 architecture.  The driver adds a character device
> (/dev/kvm) that exposes the virtualization capabilities to userspace.  Using
> this driver, a process can run a virtual machine (a "guest") in a fully
> virtualized PC containing its own virtual hard disks, network adapters, and
> display.
> 
> Using this driver, one can start multiple virtual machines on a host.  Each
> virtual machine is a process on the host; a virtual cpu is a thread in that
> process.  kill(1), nice(1), top(1) work as expected.

Where is the user space for this? Is it free? 

I suppose you need a device model. Do you use qemu's?

-Andi
