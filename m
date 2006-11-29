Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936111AbWK2UTc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936111AbWK2UTc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 15:19:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936113AbWK2UTb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 15:19:31 -0500
Received: from 1wt.eu ([62.212.114.60]:6405 "EHLO 1wt.eu") by vger.kernel.org
	with ESMTP id S936111AbWK2UTb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 15:19:31 -0500
Date: Wed, 29 Nov 2006 21:19:26 +0100
From: Willy Tarreau <w@1wt.eu>
To: prajakta choudhari <prajaktachoudhari@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Help for kernel module programming
Message-ID: <20061129201926.GC1736@1wt.eu>
References: <e9010580611282358p5966357cxf50c650819ba1710@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e9010580611282358p5966357cxf50c650819ba1710@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Nov 29, 2006 at 01:28:50PM +0530, prajakta choudhari wrote:
> Hi:
> I am writing a kernel module for assging an ip address to an interface.
> I  have included linux/igmp.h but still whenever i use the function
> declared in  igmp.h file, it says unresolved symbol for that function.
> I am new to this programming.
> i use the following command to compile it:
> gcc -c -D__KERNEL__   -DMODULE
> -I/home/newkernelsource/linux-2.4.22/include  hello.c

1) everything concerning network development should be sent to the
   netdev mailing list (netdev@vger.kernel.org)

2) to maximize your chances of getting a useful and positive reply,
   you should provide at least the part of the code using that function,
   show your includes, and, most importantly, provide a capture of the
   error messages you're seeing. It is impossible to provide any help
   with that few information.

Regards,
Willy

