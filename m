Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271708AbRJCJlB>; Wed, 3 Oct 2001 05:41:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272265AbRJCJkw>; Wed, 3 Oct 2001 05:40:52 -0400
Received: from chiara.elte.hu ([157.181.150.200]:50183 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S271708AbRJCJkn>;
	Wed, 3 Oct 2001 05:40:43 -0400
Date: Wed, 3 Oct 2001 11:38:39 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: jamal <hadi@cyberus.ca>
Cc: <linux-kernel@vger.kernel.org>, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Robert Olsson <Robert.Olsson@data.slu.se>,
        Benjamin LaHaise <bcrl@redhat.com>, <netdev@oss.sgi.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [announce] [patch] limiting IRQ load, irq-rewrite-2.4.11-B5
In-Reply-To: <Pine.GSO.4.30.0110021739160.2323-100000@shell.cyberus.ca>
Message-ID: <Pine.LNX.4.33.0110031108550.2679-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 2 Oct 2001, jamal wrote:

> This already is done in the current NAPI patch which you should have
> seen by now. [...]

(i searched the web and mailing list archives and havent found it (in fact
this is the first mention i saw) - could you give me a link so i can take
a look at it? I just found your slides but no link to actual code.
Thanks!)

but the objectives, judging from the description you gave, are i think
largely orthogonal, with some overlapping in the polling part. The polling
part of my patch is just a few quick lines here and there and it's not
intrusive at all. I needed it to make sure all problems are solved and
that the system & network is actually usable in overload situations.

you i think are concentrating on router performance (i'd add dedicated
networking appliances to the list), using cooperative drivers. I trying to
solve a DoS attack against 2.4 boxes, and i'm trying to guarantee the
uninterrupted (pun unintended) functioning of the system from the point of
the IRQ handler code.

	Ingo

