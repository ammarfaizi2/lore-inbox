Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262194AbUEKHrC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262194AbUEKHrC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 03:47:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262190AbUEKHrC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 03:47:02 -0400
Received: from fw.osdl.org ([65.172.181.6]:5063 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261704AbUEKHrA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 03:47:00 -0400
Date: Tue, 11 May 2004 00:45:51 -0700
From: Andrew Morton <akpm@osdl.org>
To: Geoff Gustafson <geoff@linux.jf.intel.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] [PATCH] Performance of del_timer_sync
Message-Id: <20040511004551.7c7af44d.akpm@osdl.org>
In-Reply-To: <409FFF3B.3090506@linux.intel.com>
References: <409FFF3B.3090506@linux.intel.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Geoff Gustafson <geoff@linux.jf.intel.com> wrote:
>
> I started this patch based on profiling an enterprise database application
>  on a 32p IA64 NUMA machine, where del_timer_sync was one of the top few
>  functions taking CPU time in the kernel.

Do you know where it's being called from?
