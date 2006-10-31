Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946152AbWJaXZm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946152AbWJaXZm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 18:25:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946156AbWJaXZm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 18:25:42 -0500
Received: from www.osadl.org ([213.239.205.134]:17307 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1946152AbWJaXZk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 18:25:40 -0500
Subject: Re: [patch 1/1] schedule removal of FUTEX_FD
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, drepper@redhat.com, mingo@elte.hu,
       rusty@rustcorp.com.au
In-Reply-To: <200610312309.k9VN9mco015260@shell0.pdx.osdl.net>
References: <200610312309.k9VN9mco015260@shell0.pdx.osdl.net>
Content-Type: text/plain
Date: Wed, 01 Nov 2006 00:27:16 +0100
Message-Id: <1162337236.15900.196.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-10-31 at 15:09 -0800, akpm@osdl.org wrote:
> From: Andrew Morton <akpm@osdl.org>
> 
> Apparently FUTEX_FD is unfixably racy and nothing uses it (or if it does, it
> shouldn't).
> 
> Add a warning printk, give any remaining users six months to migrate off it.
> 
> Cc: Ulrich Drepper <drepper@redhat.com>
> Cc: Ingo Molnar <mingo@elte.hu>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Rusty Russell <rusty@rustcorp.com.au>
> Signed-off-by: Andrew Morton <akpm@osdl.org>

ACK. 

Can you add it to Documentation/feature-removal-schedule.txt too ?

	tglx


