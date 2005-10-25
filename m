Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932339AbVJYUTN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932339AbVJYUTN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Oct 2005 16:19:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932341AbVJYUTN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Oct 2005 16:19:13 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:55174 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S932339AbVJYUTL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Oct 2005 16:19:11 -0400
Subject: Re: Oops in do_page_fault
From: Lee Revell <rlrevell@joe-job.com>
To: chase.venters@clientec.com
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <60411.67.163.102.102.1130266824.squirrel@webmail2.pair.com>
References: <60411.67.163.102.102.1130266824.squirrel@webmail2.pair.com>
Content-Type: text/plain
Date: Tue, 25 Oct 2005 15:59:10 -0400
Message-Id: <1130270350.28314.72.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-10-25 at 15:00 -0400, chase.venters@clientec.com wrote:
> Oops 0000 #1
> PREEMPT SMP
> (list of modules linked in includes some alsa modules, nvidia.ko and
> sk98lin.ko)
> 

You need to reproduce this with an untainted kernel AKA without nvidia
loaded.

> CPU 0
> EIP 0060:[<c01182c3>] Tainted: P VLI
> EFLAGS: 00010086 (2.6.13)
> EIP is at do_page_fault+0xa3/0x5db
> eax: f5e50000  ebx: 0000000b  ecx: 0000000d  edx: 0000000d
> esi: 0000000e  edi: c0567451  ebp: 00000000  esp: f5e5a10c
> 
> ds: 007b  es: 007b  ss: 0068
> 

You left out the most important part of the Oops, the stack trace.  It
should have been printed immediately after the registers.

Lee

