Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261780AbREPDdZ>; Tue, 15 May 2001 23:33:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261782AbREPDdP>; Tue, 15 May 2001 23:33:15 -0400
Received: from twinlark.arctic.org ([204.107.140.52]:27662 "HELO
	twinlark.arctic.org") by vger.kernel.org with SMTP
	id <S261780AbREPDdG>; Tue, 15 May 2001 23:33:06 -0400
Date: Tue, 15 May 2001 20:33:05 -0700 (PDT)
From: dean gaudet <dean-list-linux-kernel@arctic.org>
To: Andrea Arcangeli <andrea@suse.de>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: 2.2.20pre2aa1
In-Reply-To: <20010515235859.A2415@athlon.random>
Message-ID: <Pine.LNX.4.33.0105152029580.7281-100000@twinlark.arctic.org>
X-comment: visit http://arctic.org/~dean/legal for information regarding copyright and disclaimer.
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 May 2001, Andrea Arcangeli wrote:

> o	fixed race in wake-one LIFO in accept(2). Apache must be compiled with
> 	-DSINGLE_LISTEN_UNSERIALIZED_ACCEPT to take advantage of that.
>
> 00_wake-one-4
>
> 	Backport 2.4 waitqueues and in turn fixes an hanging condition in accept(2).
>
> 	(me)

apache since 1.3.15 has defined SINGLE_LISTEN_UNSERIALIZED_ACCEPT ...
'cause that's what you guys asked me to do :)  does this mean there are
known hangs on linux 2.2.x without your fix?

-dean

