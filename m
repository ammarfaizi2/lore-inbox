Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129565AbRBFGj3>; Tue, 6 Feb 2001 01:39:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130411AbRBFGjT>; Tue, 6 Feb 2001 01:39:19 -0500
Received: from deliverator.sgi.com ([204.94.214.10]:58407 "EHLO
	deliverator.sgi.com") by vger.kernel.org with ESMTP
	id <S130189AbRBFGjK>; Tue, 6 Feb 2001 01:39:10 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: "Miller, Brendan" <Brendan.Miller@dialogic.com>
cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: smp_num_cpus redefined? (compiling 2.2.18 for non-SMP?) 
In-Reply-To: Your message of "Mon, 05 Feb 2001 19:06:58 CDT."
             <EFC879D09684D211B9C20060972035B1D4686C@exchange2ca.sv.dialogic.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 06 Feb 2001 17:39:05 +1100
Message-ID: <1306.981441545@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Feb 2001 19:06:58 -0500 , 
"Miller, Brendan" <Brendan.Miller@Dialogic.com> wrote:
>I have a problem that would have started out as "I can't compile my device
>driver with 2.2.18".  I was compiling my device driver for non-SMP while my
>kernel (and thus /usr/src/linux) was SMP.  So I looked at compiling the
>kernel for non-SMP so that my /usr/src/linux would be non-SMP and my device
>driver would match.  Well, now just compiling 2.2.18 for non-SMP, I get
>
>In file included from /usr/src/linux-2.2.18/include/linux/modversions.h:16,
>                 from /usr/src/linux-2.2.18/include/linux/module.h:19,
>                 from ksyms.c:14:
>/usr/src/linux-2.2.18/include/linux/modules/i386_ksyms.ver:64: warning:
>`cpu_data' redefined

http://www.tux.org/lkml/#s8-8

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
