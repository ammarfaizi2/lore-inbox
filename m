Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932274AbWC1OTY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932274AbWC1OTY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 09:19:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932276AbWC1OTY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 09:19:24 -0500
Received: from mail.vtacs.com ([207.42.84.219]:25273 "EHLO mail.vtacs.com")
	by vger.kernel.org with ESMTP id S932274AbWC1OTX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 09:19:23 -0500
From: "Greg Lee" <glee@swspec.com>
To: "'Russell King'" <rmk+lkml@arm.linux.org.uk>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: HZ != 1000 causes problem with serial device shown by git-bisect
Date: Tue, 28 Mar 2006 09:17:16 -0500
Message-ID: <0f1401c65272$515bfc10$a100a8c0@casabyte.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
x-mimeole: Produced By Microsoft MimeOLE V6.00.2900.2670
In-Reply-To: <20060328081324.GA15222@flint.arm.linux.org.uk>
Thread-Index: AcZSP3/3JHVFiNVeSgCzCbWLnr6oZAAKpVaw
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Saying that the problem is between 2.6.15.6 and 2.6.16 is rather
> meaningless because you're effectively omitting _all_ the development
> work between 2.6.15 to 2.6.16, and that's likely where the problem
> lies.  Hence, you're omitting all the 2.6.16-rc kernels from your
> testing.

Yes, I realized last night that the -rc kernels actually came before the 2.6.16.  I'm in
the process of a git-bisect between 2.6.15 and 2.6.16 which will cover all of the changes
made in the -rc kernels, right?

Greg


