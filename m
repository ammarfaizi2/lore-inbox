Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268373AbSIRRvM>; Wed, 18 Sep 2002 13:51:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268369AbSIRRvL>; Wed, 18 Sep 2002 13:51:11 -0400
Received: from mx1.elte.hu ([157.181.1.137]:39837 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S268341AbSIRRui>;
	Wed, 18 Sep 2002 13:50:38 -0400
Date: Wed, 18 Sep 2002 20:02:56 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Cort Dougan <cort@fsmlabs.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Rik van Riel <riel@conectiva.com.br>, Andries Brouwer <aebr@win.tue.nl>,
       William Lee Irwin III <wli@holomorphy.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [patch] lockless, scalable get_pid(), for_each_process()
 elimination, 2.5.35-BK
In-Reply-To: <20020918113551.A654@host110.fsmlabs.com>
Message-ID: <Pine.LNX.4.44.0209182001110.25303-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 18 Sep 2002, Cort Dougan wrote:

> It's also not a bad idea to sometimes say "Linux cannot do that".  
> Trying to make the system do _everything_ will result in it doing many
> things very poorly.

sorry, but creating a new thread within some realistic time limit,
independently of how all the other threads are layed out, is not something
i'd give up trying to solve.

	Ingo

