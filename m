Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310206AbSCPKAp>; Sat, 16 Mar 2002 05:00:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310207AbSCPKAf>; Sat, 16 Mar 2002 05:00:35 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:7952 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S310206AbSCPKAX>;
	Sat, 16 Mar 2002 05:00:23 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: tigran@aivazian.fsnet.co.uk
Cc: Balbir Singh <balbir_soni@yahoo.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Nice values for kernel modules 
In-Reply-To: Your message of "Sat, 16 Mar 2002 09:51:16 -0000."
             <Pine.LNX.4.33.0203160950120.936-100000@euler24.homenet> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 16 Mar 2002 21:00:12 +1100
Message-ID: <15852.1016272812@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 16 Mar 2002 09:51:16 +0000 (GMT), 
<tigran@aivazian.fsnet.co.uk> wrote:
>On Fri, 15 Mar 2002, Balbir Singh wrote:
>> 0. I could use the TASK_NICE() macro, but I would
>>    like to avoid using it.
>> 1. Export task_nice in ksyms.c
>> 2. Use sys_nice() using a user space disguise.
>
>jump to sys_nice() indirectly via exported sys_call_table[].

Breaks on ia64 and ppc.

