Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S932135AbWFDGyH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932135AbWFDGyH (ORCPT <rfc822;akpm@zip.com.au>);
	Sun, 4 Jun 2006 02:54:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932137AbWFDGyH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jun 2006 02:54:07 -0400
Received: from liaag2ab.mx.compuserve.com ([149.174.40.153]:40879 "EHLO
	liaag2ab.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S932135AbWFDGyG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jun 2006 02:54:06 -0400
Date: Sun, 4 Jun 2006 02:49:38 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: 2.6.17-rc5-mm1
To: Laurent Riffard <laurent.riffard@free.fr>
Cc: linux-kernel@vger.kernel.org
Message-ID: <200606040252_MC3-1-C195-28D9@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <44809D5E.8020107@free.fr>

On Fri, 02 Jun 2006 22:19:42 +0200, Laurent Riffard wrote:

> OK, here is a new report done with 2.6.17-rc5-mm2 + hotfixes (namely 
> genirq-msi-fixes-2.patch, lock-validator-x86_64-irqflags-trace-entrys-fix.patch,
> revert-git-cfq.patch).
> 
> linux-2.6-mm$ grep UNWIND .config
> CONFIG_UNWIND_INFO=y
> # CONFIG_STACK_UNWIND is not set

Something strange is happening with the stack.  Can you try with 8K stacks?

kernel hacking --->
   [ ] Use 4Kb for kernel stacks instead of 8Kb

-- 
Chuck

