Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264465AbUDSOyb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 10:54:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264466AbUDSOya
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 10:54:30 -0400
Received: from fw.osdl.org ([65.172.181.6]:26557 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264465AbUDSOyO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 10:54:14 -0400
Message-Id: <200404191453.i3JErj227307@mail.osdl.org>
Date: Mon, 19 Apr 2004 07:53:39 -0700 (PDT)
From: markw@osdl.org
Subject: Re: 2.6.5-mm5
To: nickpiggin@yahoo.com.au
cc: akpm@osdl.org, linux-kernel@vger.kernel.org, mingo@elte.hu
In-Reply-To: <40824864.7060106@yahoo.com.au>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 18 Apr, Nick Piggin wrote:
> markw@osdl.org wrote:
> 
>> 
>> I do already have CONFIG_IRQBALANCE=y.  Is that the interrupt balancing?
>> I'll go ahead and get that schedstat data for you.
>> 
> 
> Hi Mark,
> Just another question (I think you've already told me once
> but I can't remember :P). Do you have HT enabled on your
> system? If so, you should have CONFIG_SCHED_SMT=y with -mm
> kernels. If not, did you get to the bottom of why oprofile
> with linus kernels says the system is P4 / Xeon, while with
> mm kernels, it is a P4 / Xeon with 2 hyper-threads?

I have HT disabled with acpi=off.  No, never was able to determine why
oprofile kept saying P4 / Xeon with 2 hyper-threads with the -mm
kernels.  I'll ask on the oprofile list.

Mark
