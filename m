Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422810AbWJaGsW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422810AbWJaGsW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 01:48:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422809AbWJaGsW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 01:48:22 -0500
Received: from smtp.osdl.org ([65.172.181.4]:7142 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1422810AbWJaGsV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 01:48:21 -0500
Date: Mon, 30 Oct 2006 22:48:02 -0800
From: Andrew Morton <akpm@osdl.org>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Arjan van de Ven <arjan@infradead.org>, Ingo Molnar <mingo@elte.hu>,
       Jiri Kosina <jikos@jikos.cz>, Marcel Holtmann <marcel@holtmann.org>,
       David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH 1/2] lockdep: spin_lock_irqsave_nested()
Message-Id: <20061030224802.f73842b8.akpm@osdl.org>
In-Reply-To: <1162199005.24143.169.camel@taijtu>
References: <1162199005.24143.169.camel@taijtu>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Oct 2006 10:03:25 +0100
Peter Zijlstra <a.p.zijlstra@chello.nl> wrote:

> Introduce spin_lock_irqsave_nested(); implementation from:
>  http://lkml.org/lkml/2006/6/1/122
> Patch from:
>  http://lkml.org/lkml/2006/9/13/258

Needed quite som massaging due to
enforce-unsigned-long-flags-when-spinlocking.patch.  Please check the
result.

