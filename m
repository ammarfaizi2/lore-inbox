Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261167AbREORcw>; Tue, 15 May 2001 13:32:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261155AbREORcp>; Tue, 15 May 2001 13:32:45 -0400
Received: from [206.14.214.140] ([206.14.214.140]:50180 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S261159AbREOR1e>; Tue, 15 May 2001 13:27:34 -0400
Date: Tue, 15 May 2001 10:27:16 -0700 (PDT)
From: James Simmons <jsimmons@transvirtual.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Jeff Garzik <jgarzik@mandrakesoft.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Neil Brown <neilb@cse.unsw.edu.au>,
        "H. Peter Anvin" <hpa@transmeta.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        viro@math.psu.edu
Subject: Re: LANANA: To Pending Device Number Registrants
In-Reply-To: <Pine.LNX.4.21.0105150838290.1802-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.10.10105151023290.22038-100000@www.transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > /dev/fbN, /dev/dspN, /dev/videoN, ...
> 
> I still don't see why they couldn't be misc drivers? 
> 
> Sure, some of them already exist and all that, and we need to support
> their major numbers just for backwards compatibility reasons. But a simple
> "give me 16 minors, please" should work fine, together with minimal
> infrastructure to create the nodes.
> 
> Think of the problem as a hot-plug issue. We don't want to statically
> allocate device numbers etc for hotplug - we create the nodes on an
> as-needed basis when the device is plugged in, and it's fairly easy to do
> with a /sbin/hotplug kind of approach.
> 
> Static devices like /dev/fbN are no different. They were just plugged in
> before the OS booted.

Actually their are hotplug video cards. High end servers have hot swapable 
graphcis cards. Would you want to take down a very important server
because the graphics card went dead. You pull it out and you plug a new
one in. Also their are PCMCIA video cards. I have seen them for the hand
held ipaqs. It is only a matter of time before all devices are hot
swappable. 

