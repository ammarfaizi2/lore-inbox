Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262093AbSIYUAZ>; Wed, 25 Sep 2002 16:00:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262095AbSIYUAY>; Wed, 25 Sep 2002 16:00:24 -0400
Received: from mx1.elte.hu ([157.181.1.137]:24972 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S262093AbSIYUAX>;
	Wed, 25 Sep 2002 16:00:23 -0400
Date: Wed, 25 Sep 2002 22:14:16 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Cort Dougan <cort@fsmlabs.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Kai Germaschewski <kai-germaschewski@uiowa.edu>,
       <linux-kernel@vger.kernel.org>, Rusty Russell <rusty@rustcorp.com.au>,
       Arjan van de Ven <arjanv@redhat.com>
Subject: Re: [ANNOUNCE] [patch] kksymoops, in-kernel symbolic oopser, 2.5.38-B0
In-Reply-To: <20020925130433.D929@duath.fsmlabs.com>
Message-ID: <Pine.LNX.4.44.0209252208480.19814-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 25 Sep 2002, Cort Dougan wrote:

> How does this change differ from the one I sent a month ago?

kallsyms/kksymoops existed for quite some time already, and there are a
couple of additional things it does:

 - it includes and uses the full symbol table, not just the module 
   symbols. (hence the 'all' in KALLSYMS)

 - as far as i can see your patch did not extend to show_stack()?

 - kksymoops prints a module list as well.

	Ingo

