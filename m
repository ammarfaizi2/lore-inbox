Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282524AbRKZVEb>; Mon, 26 Nov 2001 16:04:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282547AbRKZVEY>; Mon, 26 Nov 2001 16:04:24 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:38662 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S282531AbRKZVCv>; Mon, 26 Nov 2001 16:02:51 -0500
Subject: Re: [RFC] 2.5/2.6/2.7 transition [was Re: Linux 2.4.16-pre1]
To: landley@trommello.org
Date: Mon, 26 Nov 2001 21:08:48 +0000 (GMT)
Cc: torvalds@transmeta.com (Linus Torvalds), mfedyk@matchmail.com (Mike Fedyk),
        skraw@ithnet.com (Stephan von Krawczynski),
        kubla@sciobyte.de (Dominik Kubla), marcelo@conectiva.com.br,
        linux-kernel@vger.kernel.org
In-Reply-To: <0111261244580G.02001@localhost.localdomain> from "Rob Landley" at Nov 26, 2001 12:44:58 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E168Szh-0006un-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I submit that if the stable tree hasn't calmed down after three or four 
> months, opening a development branch may in fact HELP the situation, and 
> stabilize things faster.  You need to vent the patch pressure.

I'd tend to agree there. The new VM would have gone into 2.5.x and then back
into 2.4

In terms of release cycles there is a better method, that is simply to
codify what already happens. In truth we have yearly major releases

We went

	1.2
	1.3.59
	2.0
	2.0.30
	2.2
	2.2.14-18 merge cycle
	2.4

What we possibly should do is admit the backport phases (2.0.30/2.2.14/...)
do in fact occur and go

	2.5
	2.5 seems kind of solid at some random point but not finished
	2.6 (2.4 + 2.5 and useful bit driver backport)
	2.7 (continued 2.5)
	2.8 (actual release containing the grand changes 2.5 started)

