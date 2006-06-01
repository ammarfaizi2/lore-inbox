Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964900AbWFAJ7U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964900AbWFAJ7U (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 05:59:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964902AbWFAJ7U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 05:59:20 -0400
Received: from smtp.osdl.org ([65.172.181.4]:53706 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964900AbWFAJ7T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 05:59:19 -0400
Date: Thu, 1 Jun 2006 03:03:30 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Abu M. Muttalib" <abum@aftek.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: FW: Page Allocation Failure, Why?? Bug in kernel??
Message-Id: <20060601030330.b256d4ac.akpm@osdl.org>
In-Reply-To: <BKEKJNIHLJDCFGDBOHGMGEHNCNAA.abum@aftek.com>
References: <BKEKJNIHLJDCFGDBOHGMGEHNCNAA.abum@aftek.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Jun 2006 15:07:09 +0530
"Abu M. Muttalib" <abum@aftek.com> wrote:

> I tried to run an application, try-sound.c. In the course of the run of the
> application I repeatedly got page allocation failure, despite the fact that
> enough pages are free. Why this is so, is it a bug in mm subsystem of Linux
> kernel 2.6.13?
> 
> The Page allocation failure is as follows:
> 
> insmod: page allocation failure. order:5, mode:0xd0

We don't have a snowball's chance of allocating 32 physically-contiguous
pages.

What sound driver?

Did it actually work OK, or was there userspace-visible failure?
