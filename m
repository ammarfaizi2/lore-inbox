Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313772AbSDHWBK>; Mon, 8 Apr 2002 18:01:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313775AbSDHWBK>; Mon, 8 Apr 2002 18:01:10 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:60178 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S313772AbSDHV7R>; Mon, 8 Apr 2002 17:59:17 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: system call for finding the number of cpus??
Date: 8 Apr 2002 14:58:44 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <a8t3qk$cga$1@cesium.transmeta.com>
In-Reply-To: <6B003D25ADBDE347B5542AFE6A55B42E01A4451A@tayexc13.americas.cpqcorp.net> <1018301108.913.167.camel@phantasy> <20020408222742.A28352@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20020408222742.A28352@infradead.org>
By author:    Christoph Hellwig <hch@infradead.org>
In newsgroup: linux.dev.kernel
>
> On Mon, Apr 08, 2002 at 05:25:08PM -0400, Robert Love wrote:
> > Linux does not implement such a syscall.  Note
> > 
> > 	cat /proc/cpuinfo | grep processor | wc -l
> > 
> > works and is simple; you do not have to do it via script - execute it in
> > your C program, save the one-line output, and atoi() it.
> 
> I guess there is at least one architecture on which it breaks..
> See http://people.nl.linux.org/~hch/cpuinfo/ for details.
> 

Then that architecture should be fixed.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
