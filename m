Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310194AbSCPJyP>; Sat, 16 Mar 2002 04:54:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310197AbSCPJyF>; Sat, 16 Mar 2002 04:54:05 -0500
Received: from mail12.svr.pol.co.uk ([195.92.193.215]:24428 "EHLO
	mail12.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S310194AbSCPJxv>; Sat, 16 Mar 2002 04:53:51 -0500
Date: Sat, 16 Mar 2002 09:51:16 +0000 (GMT)
From: <tigran@aivazian.fsnet.co.uk>
X-X-Sender: <tigran@euler24.homenet>
To: Balbir Singh <balbir_soni@yahoo.com>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Nice values for kernel modules
In-Reply-To: <20020315235944.59157.qmail@web13601.mail.yahoo.com>
Message-ID: <Pine.LNX.4.33.0203160950120.936-100000@euler24.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Mar 2002, Balbir Singh wrote:
> 0. I could use the TASK_NICE() macro, but I would
>    like to avoid using it.
> 1. Export task_nice in ksyms.c
> 2. Use sys_nice() using a user space disguise.

jump to sys_nice() indirectly via exported sys_call_table[].

Regards,
Tigran

