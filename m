Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267335AbTACAJC>; Thu, 2 Jan 2003 19:09:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267338AbTACAJC>; Thu, 2 Jan 2003 19:09:02 -0500
Received: from mx2.elte.hu ([157.181.151.9]:12429 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S267335AbTACAJA>;
	Thu, 2 Jan 2003 19:09:00 -0500
Date: Fri, 3 Jan 2003 01:22:37 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Ed Tomlinson <tomlins@cam.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Robert Love <rml@tech9.net>
Subject: Re: [PATCH,RFC] fix o(1) handling of threads
In-Reply-To: <200301010802.06332.tomlins@cam.org>
Message-ID: <Pine.LNX.4.44.0301030120410.2226-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 1 Jan 2003, Ed Tomlinson wrote:

> Here is the scheduler-tunables patch updated to include USER_PENALTY and
> THREAD_PENANTY.  This on top of ptg_B0.

there's no way we'll make the scheduler internal constants tunable in such
a wide range. Such a patch has been submitted a couple of months ago
already. I do use something like that to test tunings, but it's definitely
not something we want to make tunable directly in the stock kernel.

	Ingo

