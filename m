Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262213AbUCXWaf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Mar 2004 17:30:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262193AbUCXWaf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Mar 2004 17:30:35 -0500
Received: from mx1.redhat.com ([66.187.233.31]:31370 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262227AbUCXWac (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Mar 2004 17:30:32 -0500
Date: Wed, 24 Mar 2004 14:30:28 -0800
From: "David S. Miller" <davem@redhat.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org
Subject: Re: Compile problem on sparc64
Message-Id: <20040324143028.747af65c.davem@redhat.com>
In-Reply-To: <1080160367.2309.71.camel@pegasus>
References: <1080130448.2515.108.camel@pegasus>
	<20040324121914.00fb9bf9.davem@redhat.com>
	<1080160367.2309.71.camel@pegasus>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Mar 2004 21:32:47 +0100
Marcel Holtmann <marcel@holtmann.org> wrote:

> > > I am using Debian Sid with GCC 3.3.3 (Debian 20040320) and I got the
> > > following error on my sparc64 platform while compiling the latest
> > > Bitkeeper sources from 2.6:
> > 
> > This should cure it, let me know if it doesn't.
> 
> Seems that this is not enough. Now I get this one:
> 
>   CC      arch/sparc64/kernel/process.o
> arch/sparc64/kernel/process.c: In function `flush_thread':
> arch/sparc64/kernel/process.c:435: warning: use of cast expressions as lvalues is deprecated

I'm not getting these, I wonder why.  I'm using something similar
to you for builds:

davem@nuts:/disk1/BK/sparc-2.6$ gcc --version
gcc (GCC) 3.3.3 (Debian)
Copyright (C) 2003 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

davem@nuts:/disk1/BK/sparc-2.6$

Please also send me your .config under seperate cover if you'd be so
kind, thanks.
