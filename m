Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315191AbSGMP7v>; Sat, 13 Jul 2002 11:59:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315192AbSGMP7u>; Sat, 13 Jul 2002 11:59:50 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:35312 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S315191AbSGMP7t>; Sat, 13 Jul 2002 11:59:49 -0400
Subject: Re: Advice saught on math functions
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Pavel Machek <pavel@ucw.cz>
Cc: Kirk Reiser <kirk@braille.uwo.ca>, linux-kernel@vger.kernel.org
In-Reply-To: <20020713140024.GB163@elf.ucw.cz>
References: <E17T15g-0007mP-00@speech.braille.uwo.ca>
	<E17T1a9-00037I-00@the-village.bc.nu>  <20020713140024.GB163@elf.ucw.cz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 13 Jul 2002 18:10:37 +0100
Message-Id: <1026580237.13885.17.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-07-13 at 15:00, Pavel Machek wrote:
> > You can't use FPU operations in the x86 kernel.
> 
> Actually, you can do kernel_fpu_begin(); any FPU you want;
> kernel_fpu_end(); but it is rarely good idea to do that.

Only
	Providing the CPU has FPU facilities
	Providing you do no blocking operation during the kernel_fpu_* range

Non x86 has other rules that may be even more complex.

