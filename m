Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750755AbWHFWy7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750755AbWHFWy7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Aug 2006 18:54:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750756AbWHFWy7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Aug 2006 18:54:59 -0400
Received: from smtp.osdl.org ([65.172.181.4]:25032 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750755AbWHFWy7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Aug 2006 18:54:59 -0400
Date: Sun, 6 Aug 2006 15:54:54 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.18-rc3-mm2
Message-Id: <20060806155454.50935786.akpm@osdl.org>
In-Reply-To: <200608070042.10485.rjw@sisk.pl>
References: <20060806030809.2cfb0b1e.akpm@osdl.org>
	<200608070042.10485.rjw@sisk.pl>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Aug 2006 00:42:10 +0200
"Rafael J. Wysocki" <rjw@sisk.pl> wrote:

> On Sunday 06 August 2006 12:08, Andrew Morton wrote:
> > 
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc3/2.6.18-rc3-mm2/
> 
> My box's (Asus L5D, x86_64) keyboard doesn't work on this kernel at all, even
> if I boot with init=/bin/bash.  On the 2.6.18-rc2-mm1 it worked.
> 
> Unfortunately I have no indication what can be wrong, no oopses, no error
> messages in dmesg, nothing.
> 
> Right now I'm doing a binary search for the offending patch.
> 

Thanks.  I'd zoom in on
hdaps-handle-errors-from-input_register_device.patch and git-input.patch.
