Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316532AbSFJX0S>; Mon, 10 Jun 2002 19:26:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316533AbSFJX0R>; Mon, 10 Jun 2002 19:26:17 -0400
Received: from mx2.elte.hu ([157.181.151.9]:33733 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S316532AbSFJX0Q>;
	Mon, 10 Jun 2002 19:26:16 -0400
Date: Tue, 11 Jun 2002 01:24:05 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: mingo@elte.hu
To: Mike Kravetz <kravetz@us.ibm.com>
Cc: Robert Love <rml@tech9.net>, <linux-kernel@vger.kernel.org>
Subject: Re: Scheduler Bug (set_cpus_allowed)
In-Reply-To: <20020610161559.H1565@w-mikek2.des.beaverton.ibm.com>
Message-ID: <Pine.LNX.4.44.0206110123230.4761-100000@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 10 Jun 2002, Mike Kravetz wrote:

> You might also consider adding the optimization/fast path to
> set_cpus_allowed().  Once again, I don't expect this routine (or this
> code path) to be used much, but I just hate to see us scheudle a
> migration task to set the cpu field when it is safe to do it within the
> routine.

sure, agreed. I've added it to my tree.

	Ingo

