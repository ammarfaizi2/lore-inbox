Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265393AbTLHNZx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 08:25:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265394AbTLHNZw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 08:25:52 -0500
Received: from nat-pool-bos.redhat.com ([66.187.230.200]:22465 "EHLO
	thoron.boston.redhat.com") by vger.kernel.org with ESMTP
	id S265393AbTLHNZv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 08:25:51 -0500
Date: Mon, 8 Dec 2003 08:25:48 -0500 (EST)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Ralf Orlowski <ralf@orle.de>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: crypto support in kernel 2.4.23
In-Reply-To: <200312051909.07265.ralf@orle.de>
Message-ID: <Xine.LNX.4.44.0312080825250.15586-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Dec 2003, Ralf Orlowski wrote:

> Hi,
> 
> can someone tell me, how I can get the crypto support to work in kernel
> 2.4.23.
> 
> When I try to use this, the kernel compiles just fine with crypto activated
> in the configuration. But when I then try to load the modules I always get
> these error-messages:
> 
> /lib/modules/2.4.23/kernel/crypto/twofish.o: unresolved symbol
> crypto_unregister_alg
> /lib/modules/2.4.23/kernel/crypto/twofish.o: unresolved symbol
> crypto_register_alg
> /lib/modules/2.4.23/kernel/crypto/twofish.o: insmod
> /lib/modules/2.4.23/kernel/crypto/twofish.o failed
> /lib/modules/2.4.23/kernel/crypto/twofish.o: insmod twofish failed
> 
> Does someone know, what is missing here? I couldn't find any documentation,
> that already mentions this problem.

Please post your .config.


- James
-- 
James Morris
<jmorris@redhat.com>


