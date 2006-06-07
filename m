Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932322AbWFGQuB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932322AbWFGQuB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jun 2006 12:50:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932327AbWFGQuB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jun 2006 12:50:01 -0400
Received: from smtp.osdl.org ([65.172.181.4]:59883 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932322AbWFGQuB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jun 2006 12:50:01 -0400
Date: Wed, 7 Jun 2006 09:49:43 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
Cc: nickpiggin@yahoo.com.au, mingo@elte.hu, pwil3058@bigpond.net.au,
       linux-kernel@vger.kernel.org
Subject: Re: [Patch] sched: mc/smt power savings sched policy
Message-Id: <20060607094943.0433a52c.akpm@osdl.org>
In-Reply-To: <20060606112521.A18026@unix-os.sc.intel.com>
References: <20060606112521.A18026@unix-os.sc.intel.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Jun 2006 11:25:21 -0700
"Siddha, Suresh B" <suresh.b.siddha@intel.com> wrote:

> Appended the patch. Can someone please test compile the powerpc change?

powerpc compiles and boots OK, but sparc64 is not so good.

kernel/built-in.o(.text+0x6ec0): In function `sched_create_sysfs_power_savings_entries':
: undefined reference to `smt_capable'

