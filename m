Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135378AbRDZMgT>; Thu, 26 Apr 2001 08:36:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135372AbRDZMgK>; Thu, 26 Apr 2001 08:36:10 -0400
Received: from carlsberg.amagerkollegiet.dk ([194.182.238.3]:40718 "EHLO
	carlsberg.amagerkollegiet.dk") by vger.kernel.org with ESMTP
	id <S135378AbRDZMfs>; Thu, 26 Apr 2001 08:35:48 -0400
Date: Thu, 26 Apr 2001 14:34:16 +0200 (CEST)
From: =?iso-8859-1?Q?Rasmus_B=F8g_Hansen?= <moffe@amagerkollegiet.dk>
To: <imel96@trustix.co.id>
cc: John Cavan <johnc@damncats.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Single user linux
In-Reply-To: <Pine.LNX.4.33.0104261836130.1677-100000@tessy.trustix.co.id>
Message-ID: <Pine.LNX.4.33.0104261423380.1026-100000@grignard.amagerkollegiet.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> taking place as a clueless user, i think i should be able to do anything.

Yeah, I thought so when I started using Linux. I stopped thinking so,
when I accidentally blew up the FS on my datadrive and lost
nearly _everything_ I had written for 2 years...

> i'd be happy to accept proof that multi-user is a solution for
> clueless user, not because it's proven on servers. but because it is
> a solution by definition.

Let's turn the question the other way. It's you trying to convince
us, that everyone needs root access. What does a clueless user need root
access for?

Programming - no.
Writing documents - no.
Surfing the web - no.
Reading email - no.
Installing kernels - yes (but a clueless user won't do this).
Running viruses, that blow up the entire system - yes.
Installing software - yes. But how often do you do that? And is the 'su'
   really so hard to remember?


If you really want to have different uids, why not hack xdm/login to
autologin. And when it autologins to a specific user, why do you want
different id's?

And if you really want everybody to have access to all files, you can
just do a 'chmod 777 /'. Perhaps set it up as a cronjob to run daily?

Besides you write, that a distro shipping single-user is evil. So you
want the clueless user to recompile his own kernel to enable single-user
mode (why do at all call it 'single-user' when you still have different
ID's?)... The clueless user probably does not even know what the kernel
is - and then have to recompile it...

Rasmus

-- 
-- [ Rasmus 'Møffe' Bøg Hansen ] --------------------------------------
if (getenv(EDITOR) == "vim") {karma++};
--------------------------------- [ moffe at amagerkollegiet dot dk ] -

