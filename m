Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271262AbTGPXls (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 19:41:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271272AbTGPXls
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 19:41:48 -0400
Received: from fw.osdl.org ([65.172.181.6]:62692 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S271262AbTGPXlo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 19:41:44 -0400
Date: Wed, 16 Jul 2003 16:49:17 -0700
From: Andrew Morton <akpm@osdl.org>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: greg@kroah.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] print_dev_t for 2.6.0-test1-mm
Message-Id: <20030716164917.2a7a46f4.akpm@osdl.org>
In-Reply-To: <20030717014410.A2026@pclin040.win.tue.nl>
References: <20030716184609.GA1913@kroah.com>
	<20030716130915.035a13ca.akpm@osdl.org>
	<20030716210253.GD2279@kroah.com>
	<20030716141320.5bd2a8b3.akpm@osdl.org>
	<20030716213451.GA1964@win.tue.nl>
	<20030716143902.4b26be70.akpm@osdl.org>
	<20030716222015.GB1964@win.tue.nl>
	<20030716152143.6ab7d7d3.akpm@osdl.org>
	<20030717014410.A2026@pclin040.win.tue.nl>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries Brouwer <aebr@win.tue.nl> wrote:
>
> > Why would anyone hand the kernel a 32-bit device number?  They're either 16
> > or 64, are they not?
> 
> The kernel has no control over what userspace comes with.
> And here userspace includes filesystems.
> Not all filesystems know how to come with 64 bits.

What does "comes with" mean?

Please describe a scenario in which a filesystem which works on current
kernels will, in a 64-bit-dev_t kernel, call init_special_inode() with a
16:16 encoded device number.

