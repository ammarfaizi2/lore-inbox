Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261701AbSIXQ0I>; Tue, 24 Sep 2002 12:26:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261702AbSIXQ0I>; Tue, 24 Sep 2002 12:26:08 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:62693 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S261701AbSIXQ0E>; Tue, 24 Sep 2002 12:26:04 -0400
Date: Tue, 24 Sep 2002 13:31:09 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@duckman.distro.conectiva
To: Peter Svensson <petersv@psv.nu>
Cc: Michael Sinz <msinz@wgate.com>,
       "Bill Huey (Hui)" <billh@gnuppy.monkey.org>,
       Peter Waechtler <pwaechtler@mac.com>, <linux-kernel@vger.kernel.org>,
       ingo Molnar <mingo@redhat.com>
Subject: Re: Offtopic: (was Re: [ANNOUNCE] Native POSIX Thread Library 0.1)
In-Reply-To: <Pine.LNX.4.44.0209241646170.2383-100000@cheetah.psv.nu>
Message-ID: <Pine.LNX.4.44L.0209241329590.15154-100000@duckman.distro.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Sep 2002, Peter Svensson wrote:

> For raytracers (which was the example) you need almost no coordination at
> all. Just partition the scene and you are done. This is going offtopic
> fast. The point I was making is that there is really no great reward in
> grouping threads. Either you need to educate your users and trust them to
> behave, or you need per user scheduling.

I've got per user scheduling.  I'm currently porting it to 2.4.19
(and having fun with some very subtle bugs) and am thinking about
how to port this beast to the O(1) scheduler in a clean way.

Note that it's not necessarily per user, it's trivial to adapt
the code to use any other resource container instead.

regards,

Rik
-- 
A: No.
Q: Should I include quotations after my reply?

http://www.surriel.com/		http://distro.conectiva.com/

