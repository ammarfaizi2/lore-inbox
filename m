Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261706AbVC3Bib@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261706AbVC3Bib (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 20:38:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261709AbVC3Bib
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 20:38:31 -0500
Received: from fmr24.intel.com ([143.183.121.16]:36491 "EHLO
	scsfmr004.sc.intel.com") by vger.kernel.org with ESMTP
	id S261706AbVC3Bi1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 20:38:27 -0500
Message-Id: <200503300138.j2U1cJg03717@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Nick Piggin'" <nickpiggin@yahoo.com.au>,
       "Linus Torvalds" <torvalds@osdl.org>
Cc: "'Andrew Morton'" <akpm@osdl.org>, <linux-kernel@vger.kernel.org>
Subject: RE: Industry db benchmark result on recent 2.6 kernels
Date: Tue, 29 Mar 2005 17:38:19 -0800
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcU0yDPVKrYztiK1ToGHUajNySzDtQAAHX6g
In-Reply-To: <424A0172.2010609@yahoo.com.au>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote on Tuesday, March 29, 2005 5:32 PM
> If it is doing a lot of mapping/unmapping (or fork/exit), then that
> might explain why 2.6.11 is worse.
>
> Fortunately there are more patches to improve this on the way.

Once benchmark reaches steady state, there is no mapping/unmapping
going on.  Actually, the virtual address space for all the processes
are so stable at steady state that we don't even see it grow or shrink.


