Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264374AbTEPIR4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 May 2003 04:17:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264375AbTEPIR4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 May 2003 04:17:56 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:37876 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id S264374AbTEPIRx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 May 2003 04:17:53 -0400
Date: Fri, 16 May 2003 01:30:41 -0700
Message-Id: <200305160830.h4G8Ufx01882@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: Andi Kleen <ak@suse.de>
X-Fcc: ~/Mail/linus
Cc: linux-kernel@vger.kernel.org
Subject: Re: [x86_64 PATCH] IA32 vsyscall DSO compatibility in IA32_EMULATION
In-Reply-To: Andi Kleen's message of  Friday, 16 May 2003 09:08:13 +0200 <20030516070813.GA11846@Wotan.suse.de>
Emacs: more boundary conditions than the Middle East.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Thu, May 15, 2003 at 03:39:36PM -0700, Roland McGrath wrote:
> > Btw, 2.5 ia32 core dumping on x86-64 as is crashes without the patch I just
> > posted to lkml.
> 
> Check out ftp://ftp.x86-64.org/pub/linux/v2.5/x86_64-2.5.69-4.bz2

Too bad such changes don't go into the main 2.5 tree quickly enough for me
to see them when I look.

My changes reduce the hard-coding of so many address and offset constants,
and reduce the error-prone duplication and maintenance work by using the
i386 vsyscall.lds linker script directly.  You might want to incorporate that.


Thanks,
Roland
