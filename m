Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277139AbRJDGwr>; Thu, 4 Oct 2001 02:52:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277140AbRJDGwh>; Thu, 4 Oct 2001 02:52:37 -0400
Received: from chiara.elte.hu ([157.181.150.200]:25609 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S277139AbRJDGwZ>;
	Thu, 4 Oct 2001 02:52:25 -0400
Date: Thu, 4 Oct 2001 08:50:30 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: jamal <hadi@cyberus.ca>
Cc: Simon Kirby <sim@netnation.com>, Linus Torvalds <torvalds@transmeta.com>,
        Ben Greear <greearb@candelatech.com>, <linux-kernel@vger.kernel.org>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Robert Olsson <Robert.Olsson@data.slu.se>,
        Benjamin LaHaise <bcrl@redhat.com>, <netdev@oss.sgi.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [announce] [patch] limiting IRQ load, irq-rewrite-2.4.11-B5
In-Reply-To: <Pine.GSO.4.30.0110032057000.8016-100000@shell.cyberus.ca>
Message-ID: <Pine.LNX.4.33.0110040749120.1727-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 3 Oct 2001, jamal wrote:

> I think you can save yourself a lot of pain today by going to a
> "better driver"/hardware. Switch to a tulip based board; [...]

This is not an option in many cases. (eg. where a company standardizes on
something non-tulip, or due to simple financial/organizational reasons.)
What you say is the approach i see in the FreeBSD camp frequently: "use
these [limited set of] wonderful cards and drivers, the rest sucks
hardware-design-wise and we dont really care about them", which elitist
attitude i strongly disagree with.

	Ingo

