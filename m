Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318856AbSIIUQI>; Mon, 9 Sep 2002 16:16:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318857AbSIIUQI>; Mon, 9 Sep 2002 16:16:08 -0400
Received: from mx1.elte.hu ([157.181.1.137]:11678 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S318856AbSIIUQH>;
	Mon, 9 Sep 2002 16:16:07 -0400
Date: Mon, 9 Sep 2002 22:25:13 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Daniel Jacobowitz <dan@debian.org>
Cc: Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>
Subject: Re: do_syslog/__down_trylock lockup in current BK
In-Reply-To: <20020909201516.GA7465@nevyn.them.org>
Message-ID: <Pine.LNX.4.44.0209092224580.16423-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 9 Sep 2002, Daniel Jacobowitz wrote:

> How do you reproduce this?  It's probably my fault, if it's stuck in
> zap_thread... but that's a pretty suspicious looking trace to me, if it
> goes from schedule_timeout to do_exit.

(i think i found it - patch in a few minutes.)

	Ingo

