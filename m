Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273178AbSISVYB>; Thu, 19 Sep 2002 17:24:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273214AbSISVX2>; Thu, 19 Sep 2002 17:23:28 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:13578 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S273178AbSISVXR>; Thu, 19 Sep 2002 17:23:17 -0400
Date: Thu, 19 Sep 2002 14:31:08 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Ingo Molnar <mingo@elte.hu>
cc: William Lee Irwin III <wli@holomorphy.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [patch] generic-pidhash-2.5.36-J2, BK-curr
In-Reply-To: <Pine.LNX.4.44.0209192055480.14365-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.33.0209191429410.1360-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ok, applied.

I'm also applying the session handling changes to tty_io.c as a separate
changeset, since the resulting code is certainly cleaner and reading
peoples areguments and looking at the code have made me think it _is_
correct after all.

And as a separate changeset it will be easier to test and perhaps revert 
on demand.

		Linus

