Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318379AbSGaOF0>; Wed, 31 Jul 2002 10:05:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318380AbSGaOF0>; Wed, 31 Jul 2002 10:05:26 -0400
Received: from mailrelay2.lanl.gov ([128.165.4.103]:26602 "EHLO
	mailrelay2.lanl.gov") by vger.kernel.org with ESMTP
	id <S318379AbSGaOF0>; Wed, 31 Jul 2002 10:05:26 -0400
Subject: Re: 2.5.29, CPU#1 not working with CONFIG_SMP=y, 2.5.28 OK.
From: Steven Cole <elenstev@mesatop.com>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Steven Cole <scole@lanl.gov>
In-Reply-To: <20020731020722.4D4D2421D@lists.samba.org>
References: <20020731020722.4D4D2421D@lists.samba.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2-5mdk 
Date: 31 Jul 2002 08:06:13 -0600
Message-Id: <1028124373.3085.62.camel@spc9.esa.lanl.gov>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-07-30 at 19:34, Rusty Russell wrote:
[snipped]
> 
> Hmm... this is the hint, here.  Please try the patch below (trivial,
> but untested).
> 
> Please tell the results!
> Rusty.

Yes, that worked.  Thanks.  

I had also previously applied the "Fix ksoftirqd and migration threads
initcalls" changeset 1.476.1.13 to my 2.5.29 tree.

I tested this with and without appending maxcpus=2 to the boot line.
 
Steven

