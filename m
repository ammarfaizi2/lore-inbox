Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271389AbTHHPJH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 11:09:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271391AbTHHPJH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 11:09:07 -0400
Received: from [66.212.224.118] ([66.212.224.118]:55556 "EHLO
	hemi.commfireservices.com") by vger.kernel.org with ESMTP
	id S271389AbTHHPJA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 11:09:00 -0400
Date: Fri, 8 Aug 2003 10:57:12 -0400 (EDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
X-X-Sender: zwane@montezuma.mastecende.com
To: Xiaogang Wang <xiaogang.wang@umontreal.ca>
Cc: linux-kernel@vger.kernel.org
Subject: Re: page_alloc.c bug and heavy I/O
In-Reply-To: <Pine.SGI.4.44.0308081020540.107825-100000@esirch2.ESI.UMontreal.CA>
Message-ID: <Pine.LNX.4.53.0308081052420.30770@montezuma.mastecende.com>
References: <Pine.SGI.4.44.0308081020540.107825-100000@esirch2.ESI.UMontreal.CA>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Aug 2003, Xiaogang Wang wrote:

> Hi,
> 
> My hardware and softare:
> 
>   Asus P4P800, 2GB memory, 2.8GHZ P4 with HT enabled.
>   On-board 3com Giga bit network card
>   1 parallel ata 160G maxtor disk
>   Nvidia Gefore4 MX440-8x graphics card (Asus V9180)
> 
>   Redhat 7.3, original kernel 2.4.18-3

You might want to update your RedHat kernel and if the problem persists 
report it on their bugzilla (bugzilla.redhat.com).

>   Intel Fortran Compiler 7.1
>   Intel Math Kernel Library 6.0
> 
> My problem is that one of my fortran code always crashes after 10-24 hours.
> This code has a heavy IO. It writes out a 5MB binary file every 1 minute.
> 
> The error message in  /var/log/message is: (coulson is the name of the computer)
> 
> Aug  7 21:11:29 coulson kernel: kernel BUG at page_alloc.c:226!
> Aug  7 21:11:29 coulson kernel: invalid operand: 0000
> Aug  7 21:11:29 coulson kernel: nfsd lockd sunrpc binfmt_misc sr_mod soundcore

-- 
function.linuxpower.ca
