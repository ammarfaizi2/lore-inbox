Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282116AbRK1KJC>; Wed, 28 Nov 2001 05:09:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282103AbRK1KIw>; Wed, 28 Nov 2001 05:08:52 -0500
Received: from Expansa.sns.it ([192.167.206.189]:33030 "EHLO Expansa.sns.it")
	by vger.kernel.org with ESMTP id <S282108AbRK1KIr>;
	Wed, 28 Nov 2001 05:08:47 -0500
Date: Wed, 28 Nov 2001 11:08:45 +0100 (CET)
From: Luigi Genoni <kernel@Expansa.sns.it>
To: Luke <luked@xplantechnology.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: threads & /proc
In-Reply-To: <Pine.LNX.4.33.0111281047450.1245-100000@oven.xden.xplantechnology.com>
Message-ID: <Pine.LNX.4.33.0111281107520.19132-100000@Expansa.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

on 2.4.14 I could not do kill -9 -1 as root with success to kill
everything was running (very bad idea, but it was for tests :) ).


On Wed, 28 Nov 2001, Luke wrote:

> Here's some more data about the problem reported by Anton where "ps",
> "top", "killall", etc block and "kill" doesn't work.
>
> I have encountered this behaviour with kernels 2.4.14 and 2.4.16 but not
> 2.4.13 nor 2.4.7 (although 2.4.13 hung this box in a different way).
>
> This was observed on an SMP Pentium III, which does some multithreaded
> computation.
>
> I can't give precise instructions on how to replicate this bug, but
> perhaps it can be repeated simply by exercising kernel threading?
>
> Luke.
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

