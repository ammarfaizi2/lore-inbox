Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272498AbRIFSvS>; Thu, 6 Sep 2001 14:51:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272496AbRIFSvJ>; Thu, 6 Sep 2001 14:51:09 -0400
Received: from spike.porcupine.org ([168.100.189.2]:19722 "EHLO
	spike.porcupine.org") by vger.kernel.org with ESMTP
	id <S272489AbRIFSvE>; Thu, 6 Sep 2001 14:51:04 -0400
Subject: Re: ioctl SIOCGIFNETMASK: ip alias bug 2.4.9 and 2.2.19
In-Reply-To: <20010906203646.A11741@gruyere.muc.suse.de> "from Andi Kleen at
 Sep 6, 2001 08:36:46 pm"
To: Andi Kleen <ak@suse.de>
Date: Thu, 6 Sep 2001 14:51:24 -0400 (EDT)
Cc: Wietse Venema <wietse@porcupine.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Christopher Friesen <cfriesen@nortelnetworks.com>,
        Matthias Andree <matthias.andree@stud.uni-dortmund.de>,
        Linux-Kernel mailing list <linux-kernel@vger.kernel.org>,
        linux-net@vger.kernel.org
X-Time-Zone: USA EST, 6 hours behind central European time
X-Mailer: ELM [version 2.4ME+ PL82 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Message-Id: <20010906185124.42C37BC06C@spike.porcupine.org>
From: wietse@porcupine.org (Wietse Venema)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen:
> [Sending a similar mail for the third time now; you conveniently chosed 
> to ignore all earlier ones of me in the discussion. I will not send another
> one, but just quietly think "Wietse is a moron" before forgetting the issue]

Oh, come on. I was asking for more than RTFM.

> On Wed, Sep 05, 2001 at 05:23:26PM -0400, Wietse Venema wrote:
> > On a more serious note, what portable primitives does Linux offer
> > to look up all interface IP addresses and their corresponding
> > netmasks?
> 
> man rtnetlink 7

It's not portable as you may believe.

    [root@redhat52 /root]# man rtnetlink
    No manual entry for rtnetlink

This was released only three years ago.

But it does not matter. The code needs to be written anyway.

Do you have more to share than RFTM? Pointers to code?

	Wietse
