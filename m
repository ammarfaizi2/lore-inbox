Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261187AbVCMMYR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261187AbVCMMYR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Mar 2005 07:24:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261186AbVCMMYQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Mar 2005 07:24:16 -0500
Received: from gate.crashing.org ([63.228.1.57]:18823 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261187AbVCMMYF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Mar 2005 07:24:05 -0500
Subject: Re: 2.6.11-mm3: machine check on sleep, PowerBook5.4
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Sean Neakums <sneakums@zork.net>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <6upsy37o0v.fsf@zork.zork.net>
References: <20050312034222.12a264c4.akpm@osdl.org>
	 <6upsy37o0v.fsf@zork.zork.net>
Content-Type: text/plain
Date: Sun, 13 Mar 2005 23:23:06 +1100
Message-Id: <1110716586.19810.141.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-03-13 at 12:01 +0000, Sean Neakums wrote:
> Machine check in kernel mode.
> Caused by (from SRR1=149030): Transfer error ack signal
> Oops: machine check, sig: 7 [#1]
> TASK = etc. 'pmud' etc.
> (for registers and such, see:
>  http://flynn.zork.net/~sneakums/pmac-machine-check-on-sleep-2611mm3.jpeg )
> Call trace:
>  pmac_ide_pci_suspend
>  pci_device_suspend
>  suspend_device
>  device_suspend
>  0xc03dd894
>  0xc03dddb8
>  0xc03de7cc
>  do_ioctl
>  vfs_ioctl
>  sys_ioctl
>  ret_from_syscall

Thanks, I'll investigate.

Ben.


