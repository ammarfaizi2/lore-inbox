Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261702AbTIST7S (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Sep 2003 15:59:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261714AbTIST5B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Sep 2003 15:57:01 -0400
Received: from fw.osdl.org ([65.172.181.6]:20877 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261728AbTISTyM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Sep 2003 15:54:12 -0400
Date: Fri, 19 Sep 2003 12:35:00 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Villacis, Juan" <juan.villacis@intel.com>
Cc: jbarnes@sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.x] additional kernel event notifications
Message-Id: <20030919123500.023a2b40.akpm@osdl.org>
In-Reply-To: <7F740D512C7C1046AB53446D372001732DEC70@scsmsx402.sc.intel.com>
References: <7F740D512C7C1046AB53446D372001732DEC70@scsmsx402.sc.intel.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Villacis, Juan" <juan.villacis@intel.com> wrote:
>
> Our sampling driver kernel module which uses these hooks is GPL
> and could be included in the kernel.org tree.

Ah, OK.

That code seems to have a lot of infrastructure for buffering samples,
transferring it to userspace, etc.

Have you looked into using the infrastructure in drivers/oprofile/ for
this?  In other words: is it possible to augment the kernel's existing
oprofile capabilities so they meet VTune requirements?


