Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423091AbWJSRb6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423091AbWJSRb6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 13:31:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423100AbWJSRb6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 13:31:58 -0400
Received: from mtagate4.uk.ibm.com ([195.212.29.137]:55418 "EHLO
	mtagate4.uk.ibm.com") by vger.kernel.org with ESMTP
	id S1946111AbWJSRb5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 13:31:57 -0400
Date: Thu, 19 Oct 2006 19:31:51 +0200
From: Muli Ben-Yehuda <muli@il.ibm.com>
To: Avi Kivity <avi@qumranet.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/7] KVM: Kernel-based Virtual Machine
Message-ID: <20061019173151.GD4957@rhun.haifa.ibm.com>
References: <4537818D.4060204@qumranet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4537818D.4060204@qumranet.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 19, 2006 at 03:45:49PM +0200, Avi Kivity wrote:

> The following patchset adds a driver for Intel's hardware virtualization
> extensions to the x86 architecture.  The driver adds a character device
> (/dev/kvm) that exposes the virtualization capabilities to userspace.  Using
> this driver, a process can run a virtual machine (a "guest") in a fully
> virtualized PC containing its own virtual hard disks, network adapters, and
> display.

Hi,

Looks pretty interesting! some comments:

- patch 4/7 hasn't made it to the list?
- it would be useful for reviewing this if you could post example code
  making use of the /dev/kvm interfaces - they seem fairly complex.
- why do it this way rather than through a virtual machine monitor
  such as Xen? what do you gain from having the virtual machines
  encapsulated as Linux processes?

Cheers,
Muli


