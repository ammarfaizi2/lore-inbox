Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293116AbSBWKMD>; Sat, 23 Feb 2002 05:12:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293117AbSBWKLx>; Sat, 23 Feb 2002 05:11:53 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:57560 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S293116AbSBWKLn>; Sat, 23 Feb 2002 05:11:43 -0500
Date: Sat, 23 Feb 2002 05:11:36 -0500
From: Pete Zaitcev <zaitcev@redhat.com>
Message-Id: <200202231011.g1NABaU10984@devserv.devel.redhat.com>
To: Edgar Toernig <froese@gmx.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] [PATCH] C exceptions in kernel
In-Reply-To: <mailman.1014437101.26721.linux-kernel2news@redhat.com>
In-Reply-To: <1014412325.1074.36.camel@callisto.yi.org> <mailman.1014437101.26721.linux-kernel2news@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> The attached patch implements C exceptions in the kernel,
> 
> Bad idea ...

Why is it bad? I can see a couple of reasons, but this does
not help me undestand your, unspecified, reasons.

>> which *don't* depend on special support from the compiler.
> 
> ... which can be implemented in simple ANSI-C.  See below.

Right, but the question is, do we support setjump/longjump
in kernel? The patch as I saw it does reimplement a similar thing
(check out its assembler fragments).

-- Pete
