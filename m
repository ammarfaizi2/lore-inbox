Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263027AbUDRJUm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Apr 2004 05:20:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263064AbUDRJUm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Apr 2004 05:20:42 -0400
Received: from smtp107.mail.sc5.yahoo.com ([66.163.169.227]:18057 "HELO
	smtp107.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S263027AbUDRJUl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Apr 2004 05:20:41 -0400
Message-ID: <40824864.7060106@yahoo.com.au>
Date: Sun, 18 Apr 2004 19:20:36 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040401 Debian/1.6-4
X-Accept-Language: en
MIME-Version: 1.0
To: markw@osdl.org
CC: akpm@osdl.org, linux-kernel@vger.kernel.org, mingo@elte.hu
Subject: Re: 2.6.5-mm5
References: <200404162303.i3GN3h231348@mail.osdl.org>
In-Reply-To: <200404162303.i3GN3h231348@mail.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

markw@osdl.org wrote:

> 
> I do already have CONFIG_IRQBALANCE=y.  Is that the interrupt balancing?
> I'll go ahead and get that schedstat data for you.
> 

Hi Mark,
Just another question (I think you've already told me once
but I can't remember :P). Do you have HT enabled on your
system? If so, you should have CONFIG_SCHED_SMT=y with -mm
kernels. If not, did you get to the bottom of why oprofile
with linus kernels says the system is P4 / Xeon, while with
mm kernels, it is a P4 / Xeon with 2 hyper-threads?
