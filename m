Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261680AbUKSXbc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261680AbUKSXbc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 18:31:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261637AbUKSXaj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 18:30:39 -0500
Received: from fw.osdl.org ([65.172.181.6]:15598 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261606AbUKSX0s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 18:26:48 -0500
Date: Fri, 19 Nov 2004 15:30:52 -0800
From: Andrew Morton <akpm@osdl.org>
To: Akinobu Mita <amgta@yacht.ocn.ne.jp>
Cc: hari@in.ibm.com, linux-kernel@vger.kernel.org, pbadari@us.ibm.com,
       varap@us.ibm.com
Subject: Re: [PATCH] kdump: Fix for boot problems on SMP
Message-Id: <20041119153052.21b387ca.akpm@osdl.org>
In-Reply-To: <200411200256.36218.amgta@yacht.ocn.ne.jp>
References: <419CACE2.7060408@in.ibm.com>
	<200411200256.36218.amgta@yacht.ocn.ne.jp>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Akinobu Mita <amgta@yacht.ocn.ne.jp> wrote:
>
> On Thursday 18 November 2004 23:08, Hariprasad Nellitheertha wrote:
> 
> > There was a buggy (and unnecessary) reserve_bootmem call in the kdump
> > call which was causing hangs during early on some SMP machines. The
> > attached patch removes that.
> 
> Thanks! I also had the same problem.

So..  How is the crashdump code working now?  I haven't heard from anyone
who is using it and I haven't gotten onto testing it myself.

Do we have any feeling for its success rate on various machines, and on its
ease of use?

