Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265857AbTAJSjf>; Fri, 10 Jan 2003 13:39:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265786AbTAJS36>; Fri, 10 Jan 2003 13:29:58 -0500
Received: from [193.158.237.250] ([193.158.237.250]:20361 "EHLO
	mail.intergenia.de") by vger.kernel.org with ESMTP
	id <S265857AbTAJS3f>; Fri, 10 Jan 2003 13:29:35 -0500
Date: Fri, 10 Jan 2003 19:38:18 +0100
Message-Id: <200301101838.h0AIcI505736@mail.intergenia.de>
To: <1042211459.2706.9.camel@paragon.slim>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [2.4.20] e1000 as module gives unresolved symbol _mmx_memcpy [rescued]
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> a) a kernel build for a VIA C3 doesn't use MMX, userspace programs can
> still use it

Basically true. It might be instructive to do more benching on this with
the C3 and MMX especially if the new cores add full prefetch stuff

> b) Both kernel and userspace can't use MMX any more

MMX is designed to need no OS support. SSE/SSE2 do need OS helpers but
not MMX.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

