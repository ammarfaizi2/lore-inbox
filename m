Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288550AbSADJpM>; Fri, 4 Jan 2002 04:45:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288572AbSADJpD>; Fri, 4 Jan 2002 04:45:03 -0500
Received: from mx2.elte.hu ([157.181.151.9]:16007 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S288571AbSADJon> convert rfc822-to-8bit;
	Fri, 4 Jan 2002 04:44:43 -0500
Date: Fri, 4 Jan 2002 12:42:09 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Dieter =?iso-8859-15?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [announce] [patch] ultra-scalable O(1) SMP and UP scheduler
In-Reply-To: <20020104074239.94E016DAA6@mail.elte.hu>
Message-ID: <Pine.LNX.4.33.0201041238350.2247-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 4 Jan 2002, Dieter [iso-8859-15] Nützel wrote:

> What next? Maybe a combination of O(1) and preempt?

yes, fast preemption of kernel-mode tasks and the scheduler code are
almost orthogonal. So i agree that to get the best interactive performance
we need both.

	Ingo

ps. i'm working on fixing the crashes you saw.

