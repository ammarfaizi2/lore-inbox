Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264653AbUFCPOw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264653AbUFCPOw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 11:14:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265541AbUFCPNs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 11:13:48 -0400
Received: from mo02.iij4u.or.jp ([210.130.0.19]:47344 "EHLO mo02.iij4u.or.jp")
	by vger.kernel.org with ESMTP id S265007AbUFCPFm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 11:05:42 -0400
Date: Fri, 4 Jun 2004 00:05:29 +0900
From: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To: ndiamond@despammed.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: MIPS, How to use floating point in a module?
Message-Id: <20040604000529.091f847e.yuasa@hh.iij4u.or.jp>
In-Reply-To: <200406030339.i533dHk07037@mailout.despammed.com>
References: <200406030339.i533dHk07037@mailout.despammed.com>
X-Mailer: Sylpheed version 0.9.11 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Jun 2004 22:39:17 -0500 (CDT)
ndiamond@despammed.com wrote:

> Now I am told that our next target will be a MIPS-based CPU.
> Looking at files under arch and asm includes for MIPS, I don't see
> any equivalent of the x86 (x87, 686, etc.) functions and macros
> kernel_fpu_begin, init_fpu, kernel_fpu_end, etc.  Is it safe to
> just barge ahead and use floating-point arithmetic operators when
> the driver needs to use them?

We cannot use the FPU instruction in a MIPS kernel.

Yoichi
