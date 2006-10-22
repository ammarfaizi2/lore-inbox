Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932291AbWJVIw2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932291AbWJVIw2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Oct 2006 04:52:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932292AbWJVIw2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Oct 2006 04:52:28 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:38880 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932291AbWJVIw1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Oct 2006 04:52:27 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: yhlu <yhlu.kernel@gmail.com>
Cc: "Muli Ben-Yehuda" <muli@il.ibm.com>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       "Andi Kleen" <ak@suse.de>
Subject: Re: [PATCH] x86-64: typo in __assign_irq_vector when updating pos for vector and offset
References: <200610212100.k9LL0GtC018787@hera.kernel.org>
	<20061022035109.GM5211@rhun.haifa.ibm.com>
	<86802c440610212355t237e171qf0dba82edc953066@mail.gmail.com>
Date: Sun, 22 Oct 2006 02:50:43 -0600
In-Reply-To: <86802c440610212355t237e171qf0dba82edc953066@mail.gmail.com>
	(yhlu.kernel@gmail.com's message of "Sat, 21 Oct 2006 23:55:28 -0700")
Message-ID: <m1lkn820po.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

yhlu <yhlu.kernel@gmail.com> writes:

> can you try to add command line pci=routeirq?
>
> also if put the driver in the kernel?

YH we have an irq number so it doesn't appear to be a routing
problem.  Much more likely that the vector allocator decided
to fail.

Probably just some stupid thing with vector_irq.

Eric
