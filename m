Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270702AbTG0I5g (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 04:57:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270703AbTG0I5g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 04:57:36 -0400
Received: from mx2.elte.hu ([157.181.151.9]:40615 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S270702AbTG0I5e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 04:57:34 -0400
Date: Sun, 27 Jul 2003 11:12:12 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Willy Tarreau <willy@w.ods.org>
Cc: Con Kolivas <kernel@kolivas.org>, Andrew Morton <akpm@osdl.org>,
       Daniel Phillips <phillips@arcor.de>, <ed.sweetman@wmich.edu>,
       <eugene.teo@eugeneteo.net>, <linux-kernel@vger.kernel.org>
Subject: Re: Ingo Molnar and Con Kolivas 2.6 scheduler patches
In-Reply-To: <20030727073920.GG643@alpha.home.local>
Message-ID: <Pine.LNX.4.44.0307271110140.7393-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 27 Jul 2003, Willy Tarreau wrote:

> just a thought : have you tried to set the timer to 100Hz instead of
> 1kHz to compare with 2.4 ? It might make a difference too.

especially for X, a HZ of 1000 has caused performance problems before -
short-timeout select()s were looping 10 times faster, which can be
noticeable.

	Ingo

