Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263142AbRE1Utv>; Mon, 28 May 2001 16:49:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263143AbRE1Utm>; Mon, 28 May 2001 16:49:42 -0400
Received: from www.wen-online.de ([212.223.88.39]:29704 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S263142AbRE1Ute>;
	Mon, 28 May 2001 16:49:34 -0400
Date: Mon, 28 May 2001 22:49:13 +0200 (CEST)
From: Mike Galbraith <mikeg@wen-online.de>
X-X-Sender: <mikeg@mikeg.weiden.de>
To: "Leeuw van der, Tim" <tim.leeuwvander@nl.unisys.com>
cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.5-ac2
In-Reply-To: <DD0DC14935B1D211981A00105A1B28DB033ED2F0@NL-ASD-EXCH-1>
Message-ID: <Pine.LNX.4.33.0105282126550.366-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 May 2001, Leeuw van der, Tim wrote:

> The VM in 2.4.5 might be largely 'fixed' and I know that the VM changes in
> -ac were considered to be but still broken, however for me they worked
> better than what is in 2.4.5.

The VM changes in 2.4.5 fixed a very serious performance problem.  IMHO,
2.4.5 is a step in the right direction.  (and I hope more steps are in
the offing;)

> I have a rather aging P5MMX at 200MHz with 64MB RAM, and I'm only judging
> interactive use (not measuring anything like compile times etc).

Interactive performance became a problem here exactly at the point when
we stopped waiting for the vm to produce results.  (which rather sucks,
because that's also the spot where throughput improved [non-suprise])

	-Mike

