Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030292AbWCUCQU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030292AbWCUCQU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 21:16:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030298AbWCUCQU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 21:16:20 -0500
Received: from smtp.osdl.org ([65.172.181.4]:22968 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030292AbWCUCQT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 21:16:19 -0500
Date: Mon, 20 Mar 2006 18:12:55 -0800
From: Andrew Morton <akpm@osdl.org>
To: prasanna@in.ibm.com
Cc: ak@suse.de, davem@davemloft.net, suparna@in.ibm.com,
       richardj_moore@uk.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [2/3 PATCH] Kprobes: User space probes support- readpage hooks
Message-Id: <20060320181255.16932b0d.akpm@osdl.org>
In-Reply-To: <20060320134839.GF8662@in.ibm.com>
References: <20060320060745.GC31091@in.ibm.com>
	<20060320060931.GD31091@in.ibm.com>
	<20060320061014.GE31091@in.ibm.com>
	<20060320025311.419a44e3.akpm@osdl.org>
	<20060320134839.GF8662@in.ibm.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Prasanna S Panchamukhi <prasanna@in.ibm.com> wrote:
>
> The basic idea is to insert probes on user applications which may or
>  may not be in memory, at the time of probe insertion.

umm yes, but what for?

What does this entire feature *do*?  Why does Linux need it?

OK, so it allows kernel modules to set breakpoints (via debug traps) into
user code.  But why do we want to be able to do that?  What are the
use-cases?

This may sound like boringly obvious stuff to you, but without a complete
problem statement from the designers, how are we to evaluate their proposed
solution?

