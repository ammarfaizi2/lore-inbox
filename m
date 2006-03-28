Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751308AbWC1SOY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751308AbWC1SOY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 13:14:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751310AbWC1SOY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 13:14:24 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:40621 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751308AbWC1SOY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 13:14:24 -0500
Subject: Re: 2.6.16-mm2
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20060328003508.2b79c050.akpm@osdl.org>
References: <20060328003508.2b79c050.akpm@osdl.org>
Content-Type: text/plain
Date: Tue, 28 Mar 2006 10:16:18 -0800
Message-Id: <1143569778.26106.5.camel@dyn9047017100.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-03-28 at 00:35 -0800, Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16/2.6.16-mm2/
> 
> 
> - It seems to compile.

Well, depends :)

Ran into this on -mm1 also. Haven't digged into finding out why ?

  LD      init/built-in.o
  LD      .tmp_vmlinux1
arch/x86_64/mm/built-in.o(.init.text+0x1298): In function `__change_page_attr':
arch/x86_64/mm/pageattr.c:58: undefined reference to `srat_reserve_add_area'
make: *** [.tmp_vmlinux1] Error 1

Ideas ?

Thanks,
Badari

