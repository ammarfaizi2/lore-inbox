Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262687AbTJKQKf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Oct 2003 12:10:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263159AbTJKQKf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Oct 2003 12:10:35 -0400
Received: from mx2.elte.hu ([157.181.151.9]:1513 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262687AbTJKQKd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Oct 2003 12:10:33 -0400
Date: Sat, 11 Oct 2003 18:08:21 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
Subject: Re: [patch] SMP races in the timer code, timer-fix-2.6.0-test7-A0
In-Reply-To: <Pine.LNX.4.56.0310111713440.8641@earth>
Message-ID: <Pine.LNX.4.56.0310111807590.10679@earth>
References: <3F881B46.6070301@colorfullife.com> <Pine.LNX.4.56.0310111713440.8641@earth>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 11 Oct 2003, Ingo Molnar wrote:

> since this would be the 8th word-sized field in struct timer_list,
> making it a nice round structure size.

it's the 9th field in fact, due to timer->magic.

	Ingo
