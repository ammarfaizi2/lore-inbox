Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270018AbRHJWQz>; Fri, 10 Aug 2001 18:16:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270661AbRHJWQp>; Fri, 10 Aug 2001 18:16:45 -0400
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:57965 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S270018AbRHJWQa>; Fri, 10 Aug 2001 18:16:30 -0400
Date: Fri, 10 Aug 2001 18:16:37 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
Message-Id: <200108102216.f7AMGbY24935@devserv.devel.redhat.com>
To: jack@ucw.cz
Cc: linux-kernel@vger.kernel.org
Subject: Re: byteorder.h
In-Reply-To: <mailman.997447201.20256.linux-kernel2news@redhat.com>
In-Reply-To: <mailman.997447201.20256.linux-kernel2news@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>   I think I've found a small bug in asm-ppc/byteorder.h. The problem is that symbol
> __BYTEORDER_HAS_U64__ is defined only if __KERNEL__ is defined but on other archs
> it's defined also if __STRICT_ANSI__ is not defined and this is IMHO right.

Why do you care?

-- Pete
