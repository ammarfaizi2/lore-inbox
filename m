Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271808AbRHWLzZ>; Thu, 23 Aug 2001 07:55:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271813AbRHWLzQ>; Thu, 23 Aug 2001 07:55:16 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:63728 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S271808AbRHWLzG>;
	Thu, 23 Aug 2001 07:55:06 -0400
Date: Thu, 23 Aug 2001 07:55:20 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Richard J Moore <richardj_moore@uk.ibm.com>
cc: Keith Owens <kaos@ocs.com.au>, linux-kernel@vger.kernel.org
Subject: Re: Is there any interest in Dynamic API
In-Reply-To: <OF7D126203.EB32E22D-ON80256AB1.003EC909@portsmouth.uk.ibm.com>
Message-ID: <Pine.GSO.4.21.0108230754240.13586-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 23 Aug 2001, Richard J Moore wrote:

> 
> 
> 
> On Thu, 23 Aug 2001 10:21:25 +0100,
> "Keith Owens" <kaos@ocs.com.au> wrote:
> >>Thanks, these are good areguments for not pursuing this. We'll proceed
> with
> >>conversion of dprobes to a device driver rather than a kernel module.
> >
> >I presume you meant a device driver rather than a syscall interface.
> >Obviously a driver can be a module.
> 
> Yes, kernel_mod+syscall to ddev+ioclt instead of kmod+syscall

s/ioctl/read() and write()/, please.

