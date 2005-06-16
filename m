Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261688AbVFPUk3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261688AbVFPUk3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Jun 2005 16:40:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261764AbVFPUk3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Jun 2005 16:40:29 -0400
Received: from nevyn.them.org ([66.93.172.17]:25803 "EHLO nevyn.them.org")
	by vger.kernel.org with ESMTP id S261688AbVFPUkW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Jun 2005 16:40:22 -0400
Date: Thu, 16 Jun 2005 16:40:19 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: Wolfgang Wander <wwc@rentec.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: problem with gdb back-traces on AMD64 (32 bit executables)
Message-ID: <20050616204019.GA8434@nevyn.them.org>
Mail-Followup-To: Wolfgang Wander <wwc@rentec.com>,
	linux-kernel@vger.kernel.org
References: <17073.38338.924758.578274@gargle.gargle.HOWL>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17073.38338.924758.578274@gargle.gargle.HOWL>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 16, 2005 at 11:07:46AM -0400, Wolfgang Wander wrote:
> This is regarding a gdb problem regarding stack back-traces with
> AMD64 and -m32 compiled executables.  When the program receives
> a signal inside a shared library of an m32 executable (or if 
> one attaches to such a program and it executes a shared library
> function) back traces are useless.
> 
> I'm sending this to the kernel list for two reasons:
> 
>   a) the gdb maintainers have not shown any interest in the issue, yet
>      ;-), maybe because of b)
>   b) the problem only affects 2.6 kernels, 2.4 kernels are fine.

It's not a kernel bug.  Please try GDB CVS again, since HJ recently
committed a related fix for x86_64 GDB.


-- 
Daniel Jacobowitz
CodeSourcery, LLC
