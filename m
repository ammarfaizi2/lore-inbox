Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964876AbVKQVMY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964876AbVKQVMY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 16:12:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964874AbVKQVMY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 16:12:24 -0500
Received: from lakshmi.addtoit.com ([198.99.130.6]:3343 "EHLO
	lakshmi.solana.com") by vger.kernel.org with ESMTP id S964876AbVKQVMY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 16:12:24 -0500
Date: Thu, 17 Nov 2005 17:04:36 -0500
From: Jeff Dike <jdike@addtoit.com>
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
Cc: akpm@osdl.org, Linux kernel <linux-kernel@vger.kernel.org>,
       user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [PATCH 3/4] UML - Properly invoke x86_64 system calls
Message-ID: <20051117220436.GA10871@ccure.user-mode-linux.org>
References: <200511172110.jAHLASIB010204@ccure.user-mode-linux.org> <Pine.LNX.4.61.0511171528570.10664@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0511171528570.10664@chaos.analogic.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Wrongbot,
	Thank you for your concern.

On Thu, Nov 17, 2005 at 03:37:14PM -0500, linux-os (Dick Johnson) wrote:
> In 64-bit world, the same is supposed to apply as well.
> If RCX is now precious, it's a GCC bug that should be fixed.
> 
> Yes?

No.

Here's a technical tidbit for you to digest, mangle, and later regurgitate
in yor usual pseudo-authoritative manner:

	The x86_64 syscall instruction is defined to contain the process 
	return address on return to userspace.  Hence, it (like RAX) is
	destroyed by the syscall instruction.

				Jeff
