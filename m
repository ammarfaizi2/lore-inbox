Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288855AbSBDKe1>; Mon, 4 Feb 2002 05:34:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288854AbSBDKeR>; Mon, 4 Feb 2002 05:34:17 -0500
Received: from mx2.elte.hu ([157.181.151.9]:35782 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S288855AbSBDKeH>;
	Mon, 4 Feb 2002 05:34:07 -0500
Date: Mon, 4 Feb 2002 13:30:00 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Ed Tomlinson <tomlins@cam.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] improving O(1)-J9 in heavily threaded situations
In-Reply-To: <20020204044055.EF0579251@oscar.casa.dyndns.org>
Message-ID: <Pine.LNX.4.33.0202041317400.4090-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 3 Feb 2002, Ed Tomlinson wrote:

> Maybe we can control this with nice.  Is the the best or only way to
> do it?  I am not at all sure it is.  After all nice is just another
> knob.  The fewer knobs we have to tweak the easier linux is to use.

> [...] On the other hand if we can figure a way to add a simple and
> understandable knob that let it perform better under load do not think
> its a bad thing either.

comparing these two paragraphs you'll see what kind of paradox we face.
I'm trying to keep the number of external knobs down, and i'm trying to
revive nice levels as a thing that makes some real difference, while still
handling all the important cases automatically, wherever we can.

	Ingo

