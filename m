Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316585AbSFQRDt>; Mon, 17 Jun 2002 13:03:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316587AbSFQRDs>; Mon, 17 Jun 2002 13:03:48 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:18692 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S316585AbSFQRDr>; Mon, 17 Jun 2002 13:03:47 -0400
Date: Mon, 17 Jun 2002 10:04:09 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Ingo Molnar <mingo@elte.hu>
cc: Robert Love <rml@tech9.net>, <linux-kernel@vger.kernel.org>
Subject: Re: [patch] sti() preemption fix, 2.5.22
In-Reply-To: <Pine.LNX.4.44.0206171811170.18282-100000@e2>
Message-ID: <Pine.LNX.4.44.0206171003290.2580-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 17 Jun 2002, Ingo Molnar wrote:
>
> correct patch attached.

Ingo, please use "get_cpu()/put_cpu()" instead, which does exactly the
preempt-disable etc, and is more readable.

		Linus

