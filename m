Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268465AbUHTR5F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268465AbUHTR5F (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 13:57:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268467AbUHTR5E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 13:57:04 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:57323 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S268465AbUHTRz6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 13:55:58 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: mita akinobu <amgta@yacht.ocn.ne.jp>
Subject: Re: 2.6.8.1-mm3 (build failture w/ CONFIG_NUMA)
Date: Fri, 20 Aug 2004 13:55:22 -0400
User-Agent: KMail/1.6.2
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20040820031919.413d0a95.akpm@osdl.org> <200408210238.32922.amgta@yacht.ocn.ne.jp>
In-Reply-To: <200408210238.32922.amgta@yacht.ocn.ne.jp>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200408201355.22999.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, August 20, 2004 1:38 pm, mita akinobu wrote:
> I had tried to compile with CONFIG_NUMA and got this error:
>
>   CC      kernel/sched.o
> kernel/sched.c: In function `sched_domain_node_span':
> kernel/sched.c:4001: error: invalid lvalue in unary `&'
> make[1]: *** [kernel/sched.o] Error 1
> make: *** [kernel] Error 2
>
> Below patch fixes this.

Darn, I should have tried with NR_CPUS < 64 too.  Thanks for the fix.

Jesse
