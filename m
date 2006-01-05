Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751935AbWAEGw0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751935AbWAEGw0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 01:52:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751913AbWAEGw0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 01:52:26 -0500
Received: from smtp.osdl.org ([65.172.181.4]:61381 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750704AbWAEGwZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 01:52:25 -0500
Date: Wed, 4 Jan 2006 22:52:09 -0800
From: Andrew Morton <akpm@osdl.org>
To: Dane Mutters <dmutters@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: (1) ACPI messes up Parallel support in kernels >2.6.9
Message-Id: <20060104225209.56e35802.akpm@osdl.org>
In-Reply-To: <200601042203.12377.dmutters@gmail.com>
References: <200601042203.12377.dmutters@gmail.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dane Mutters <dmutters@gmail.com> wrote:
>
> 	I've been attempting to figure out this problem for a long time, and have 
>  come to the conclusion that it must be a kernel bug (that or perhaps I'm a 
>  bit dense).  Whenever I have the option, "Device Drivers > Plug and Play > 
>  ACPI Support" enabled, I become unable to print using my parallel port.

hm, regressions are bad and the fact that it _used_ to work meand that we
should be able to make it work again.

Could you please raise a bug reports against acpi at bugzilla.kernel.org? 
It might help if that report includes the output of `dmesg -s 1000000' for
both working and non-working kernels.

Thanks.

