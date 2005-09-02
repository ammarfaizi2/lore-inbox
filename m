Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750860AbVIBUNG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750860AbVIBUNG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 16:13:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751160AbVIBUNG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 16:13:06 -0400
Received: from smtp.osdl.org ([65.172.181.4]:35486 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750860AbVIBUNE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 16:13:04 -0400
Date: Fri, 2 Sep 2005 13:11:22 -0700
From: Andrew Morton <akpm@osdl.org>
To: Peter Williams <pwil3058@bigpond.net.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-mm1: hangs during boot ...
Message-Id: <20050902131122.4c634211.akpm@osdl.org>
In-Reply-To: <43184B8A.4040801@bigpond.net.au>
References: <43184B8A.4040801@bigpond.net.au>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Williams <pwil3058@bigpond.net.au> wrote:
>
> ... at the the point indicated by the following output:
> 
> [    8.197224] Freeing unused kernel memory: 288k freed
> [    8.428217] SCSI subsystem initialized
> [    8.510376] sym0: <810a> rev 0x23 at pci 0000:00:08.0 irq 11
> [    8.587731] sym0: No NVRAM, ID 7, Fast-10, SE, parity checking
> [    8.671531] sym0: SCSI BUS has been reset.
> [    8.725530] scsi0 : sym-2.2.1
> [   17.256480]  0:0:0:0: ABORT operation started.
> [   22.323534]  0:0:0:0: ABORT operation timed-out.
> [   22.384348]  0:0:0:0: DEVICE RESET operation started.
> [   27.458702]  0:0:0:0: DEVICE RESET operation timed-out.
> [   27.527544]  0:0:0:0: BUS RESET operation started.
> [   32.533775]  0:0:0:0: BUS RESET operation timed-out.
> [   32.599173]  0:0:0:0: HOST RESET operation started.
> [   32.669659] sym0: SCSI BUS has been reset.
> 

Is there no response from sysrq-T?

Maybe adding initcall_debug to the boot command line will show extra info?

The .config would be useful, thanks.
