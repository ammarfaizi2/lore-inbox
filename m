Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266993AbSKVIbx>; Fri, 22 Nov 2002 03:31:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266996AbSKVIbx>; Fri, 22 Nov 2002 03:31:53 -0500
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:11024 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S266993AbSKVIbx>; Fri, 22 Nov 2002 03:31:53 -0500
Message-Id: <200211220832.gAM8W4p30533@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Dave Jones <davej@codemonkey.org.uk>,
       Margit Schubert-While <margitsw@t-online.de>
Subject: Re: P4 compile options
Date: Fri, 22 Nov 2002 11:22:53 -0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
References: <4.3.2.7.2.20021121210830.00b58890@mail.dns-host.com> <20021121204056.GA19455@suse.de>
In-Reply-To: <20021121204056.GA19455@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 21 November 2002 18:40, Dave Jones wrote:
> On Thu, Nov 21, 2002 at 09:18:30PM +0100, Margit Schubert-While wrote:
>  > Maybe a dumb question -
>  > Is it possible to use the "-march=pentium4 -mfpmath=sse -msse2"
>  > options for a P4 ?
>  > I notice anything over a P2 just gets "-march=i686".
>
> This is already done in 2.5. (Well, the -march anyways)

I'd say benefits of compiling p4-optimized code are questionable.
Are you sure your kernel will run faster, not slower?
Benchmark numbers? Or it's only warm and fuzzy feeling?

Warm and fuzzy feelings of kernels compiled for very new processors
quickly disappear when you try to boot e.g. 486 with them ;)
--
vda
