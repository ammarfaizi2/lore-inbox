Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261648AbVDEJoj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261648AbVDEJoj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 05:44:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261654AbVDEJml
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 05:42:41 -0400
Received: from ozlabs.org ([203.10.76.45]:17053 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261656AbVDEJfs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 05:35:48 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16978.23538.676953.730507@cargo.ozlabs.ibm.com>
Date: Tue, 5 Apr 2005 19:35:46 +1000
From: Paul Mackerras <paulus@samba.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Andrew Morton <akpm@osdl.org>, Dave Airlie <airlied@linux.ie>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc2-mm1
In-Reply-To: <20050405091255.GA28343@infradead.org>
References: <20050405000524.592fc125.akpm@osdl.org>
	<20050405074405.GE26208@infradead.org>
	<16978.22078.532831.667378@cargo.ozlabs.ibm.com>
	<20050405091255.GA28343@infradead.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig writes:

> It's documented where the other filesystem entry points are documented.

Which is?

$ grep -r compat_ioctl Documentation
Documentation/filesystems/Locking:      long (*compat_ioctl) (struct file *, unsigned int, unsigned long);
Documentation/filesystems/Locking:compat_ioctl:         no

Marvellous documentation, that. :)

> This is not about beeing impatient but about adding APIs that at the same
> time are actively removed all over the tree.

Sure, just don't be so impatient... :)

> You can of course take the BKL inside your ->compat_ioctl method.

Yes, the question is whether we need to or not.

Paul.
