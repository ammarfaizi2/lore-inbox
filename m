Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161166AbWKHQYl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161166AbWKHQYl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 11:24:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161177AbWKHQYl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 11:24:41 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:23990 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1161166AbWKHQYk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 11:24:40 -0500
Subject: Re: How to interpret MCE messages?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: martin f krafft <madduck@madduck.net>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <20061108162022.GA4258@piper.madduck.net>
References: <20061108162022.GA4258@piper.madduck.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 08 Nov 2006 16:29:13 +0000
Message-Id: <1163003354.23956.43.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Mer, 2006-11-08 am 17:20 +0100, ysgrifennodd martin f krafft:
> Thanks to mcelog, I am now regularly seeing messages like this on an
> amd64 machine:
> 
>   kernel: Machine check events logged
>         bit46 = corrected ecc error
>     Data cache ECC error (syndrome 5b)

Cache.. not memory

>     memory/cache error 'data read mem transaction, data transaction, level 2'

L2 Cache

> Before I go out and buy a new motherboard (as I assume that it's
> a L1/L2 cache problem), 

L1/L2 cache are on the CPU these days. Double check with the processor
docs and vendor but I think mcelog is actually trying to tell you that
the CPU wants to be warranty returned. It might also of course be a heat
problem.


