Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261567AbUCBFoa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Mar 2004 00:44:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261568AbUCBFoa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Mar 2004 00:44:30 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:29843 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S261567AbUCBFo2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Mar 2004 00:44:28 -0500
To: "Tolentino, Matthew E" <matthew.e.tolentino@intel.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: [CFT][PATCH] 2.6.4-rc1 remove x86 boot page tables
References: <D36CE1FCEFD3524B81CA12C6FE5BCAB002FFE999@fmsmsx406.fm.intel.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 01 Mar 2004 22:36:15 -0700
In-Reply-To: <D36CE1FCEFD3524B81CA12C6FE5BCAB002FFE999@fmsmsx406.fm.intel.com>
Message-ID: <m1znaz6ca8.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Tolentino, Matthew E" <matthew.e.tolentino@intel.com> writes:

> > I have rewritten and compiled tested the boot_ioremap code but I don't
> > have a configuration to test it. This effects the EFI code and the
> > numa srat code.   It might be worth replacing boot_ioremap with __va()
> > to reduce the amount of error checking necessary.
> 
> I just blindly applied this patch and tried it on an x86 EFI system
> with no luck.  It's not mapping correctly for some reason.  I'll look
> at the problem closer in a bit.

Thanks I'd appreciate it.  There is the earlyprintk fix patch I posted
earlier that might help.

You say it is not mapping correctly?  What do you mean?  Is it
a bug in boot_ioremap or something else.  Or do you know yet?

Thanks,

Eric
