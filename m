Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317816AbSHCVNs>; Sat, 3 Aug 2002 17:13:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317817AbSHCVNs>; Sat, 3 Aug 2002 17:13:48 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:15861 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S317816AbSHCVNr>; Sat, 3 Aug 2002 17:13:47 -0400
Subject: Re: Problem with AHA152X driver in 2.4.19
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Marc Lefranc <lefranc.m@free.fr>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <p6r65yrlvt1.fsf@free.fr>
References: <p6r65yrlvt1.fsf@free.fr>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 03 Aug 2002 23:35:14 +0100
Message-Id: <1028414114.1760.40.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-08-03 at 18:02, Marc Lefranc wrote:
>------------------------------------------------
> Aug  3 17:44:55 socrate kernel: Unable to handle kernel NULL pointer dereference
>  at virtual address 0000001b
> Aug  3 17:44:55 socrate kernel:  printing eip:
> Aug  3 17:44:55 socrate kernel: c68a21d9
> Aug  3 17:44:55 socrate kernel: *pde = 00000000
> Aug  3 17:44:55 socrate kernel: Oops: 0000
> Aug  3 17:44:55 socrate kernel: CPU:    0
> Aug  3 17:44:55 socrate kernel: EIP:    0010:[<c68a21d9>]    Not tainted
> Aug  3 17:44:55 socrate kernel: EFLAGS: 00010002
> Aug  3 17:44:55 socrate kernel: eax: 00000000   ebx: c2575000   ecx: c26e9e30   
> edx: c1d9a240

You need to run through the oops through the ksymoops decoder (see
REPORTING-BUGS in the kernel)
