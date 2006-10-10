Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030593AbWJJWR4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030593AbWJJWR4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 18:17:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030592AbWJJWRz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 18:17:55 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:13536
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1030591AbWJJWRx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 18:17:53 -0400
Date: Tue, 10 Oct 2006 15:17:51 -0700 (PDT)
Message-Id: <20061010.151751.90998930.davem@davemloft.net>
To: simoneau@ele.uri.edu
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [sparc64] 2.6.18 unaligned accesses in eth1394
From: David Miller <davem@davemloft.net>
In-Reply-To: <20061010132943.GB18539@ele.uri.edu>
References: <20061005211543.GA18539@ele.uri.edu>
	<20061009.183607.63736982.davem@davemloft.net>
	<20061010132943.GB18539@ele.uri.edu>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Will Simoneau <simoneau@ele.uri.edu>
Date: Tue, 10 Oct 2006 09:29:43 -0400

> I still get:
> 
> Kernel unaligned access at TPC[10162164] ether1394_reset_priv+0x2c/0xe0 [eth1394]
> Kernel unaligned access at TPC[10163148] ether1394_data_handler+0xdd0/0x1060 [eth1394]
> 
> The second one triggers on every packet received, the first only triggers once in a while.
> 
> If you want more gdb info or a disassembly just ask.

Hmmm, can you do me a favor?  Build ieee1394 and eth1394 statically
into your kernel, reproduce, and post the kernel log messages
and the vmlinux image somewhere where I can fetch them.

I should be able to fix this once I have that.

Thanks a lot.
