Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273836AbRJDLw3>; Thu, 4 Oct 2001 07:52:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273846AbRJDLwT>; Thu, 4 Oct 2001 07:52:19 -0400
Received: from shell.cyberus.ca ([209.195.95.7]:44473 "EHLO shell.cyberus.ca")
	by vger.kernel.org with ESMTP id <S273836AbRJDLwI>;
	Thu, 4 Oct 2001 07:52:08 -0400
Date: Thu, 4 Oct 2001 07:49:46 -0400 (EDT)
From: jamal <hadi@cyberus.ca>
To: Ingo Molnar <mingo@elte.hu>
cc: Simon Kirby <sim@netnation.com>, Linus Torvalds <torvalds@transmeta.com>,
        Ben Greear <greearb@candelatech.com>, <linux-kernel@vger.kernel.org>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Robert Olsson <Robert.Olsson@data.slu.se>,
        Benjamin LaHaise <bcrl@redhat.com>, <netdev@oss.sgi.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [announce] [patch] limiting IRQ load, irq-rewrite-2.4.11-B5
In-Reply-To: <Pine.LNX.4.33.0110040749120.1727-100000@localhost.localdomain>
Message-ID: <Pine.GSO.4.30.0110040747560.9341-100000@shell.cyberus.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 4 Oct 2001, Ingo Molnar wrote:

>
> On Wed, 3 Oct 2001, jamal wrote:
>
> > I think you can save yourself a lot of pain today by going to a
> > "better driver"/hardware. Switch to a tulip based board; [...]
>
> This is not an option in many cases. (eg. where a company standardizes on
> something non-tulip, or due to simple financial/organizational reasons.)
> What you say is the approach i see in the FreeBSD camp frequently: "use
> these [limited set of] wonderful cards and drivers, the rest sucks
> hardware-design-wise and we dont really care about them", which elitist
> attitude i strongly disagree with.
>

It is not elitist. Maybe we can force people to use the API now. it
exists. And hardware flow control does not require special hardware
features. As well NAPI kills the requirement for mitigation in the future.

cheers,
jamal

