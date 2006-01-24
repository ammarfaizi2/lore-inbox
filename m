Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030394AbWAXI4H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030394AbWAXI4H (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jan 2006 03:56:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030401AbWAXI4E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jan 2006 03:56:04 -0500
Received: from liaag1ad.mx.compuserve.com ([149.174.40.30]:7660 "EHLO
	liaag1ad.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1030395AbWAXI4C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jan 2006 03:56:02 -0500
Date: Tue, 24 Jan 2006 03:53:40 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [patch 0/9] Shared ia32 syscall table
To: Andi Kleen <ak@suse.de>
Cc: Jeff Dike <jdike@addtoit.com>,
       "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200601240355_MC3-1-B687-9FD3@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <200601240141.08152.ak@suse.de>

On Tue, 24 Jan 2006 at 01:41:07 +0100, Andi Kleen wrote:

> On Tuesday 24 January 2006 01:36, Chuck Ebbert wrote:
> > This patch series updates i386 and x86_64 so they share
> > the same ia32 syscall table.  UML already uses the i386
> > table and is updated to use the new shared table as well.
> 
> That's wrong for x86-64. The IA32 syscall table needs
> to point to compat_* version of syscalls, while the native
> IA32 table uses sys_* directly.

How could I have possibly gotten a successful boot of an i386
distro on top of the patched x86_64 kernel if this were wrong?

Did you even look at the patches?
-- 
Chuck

