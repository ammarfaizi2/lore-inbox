Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261565AbREOVai>; Tue, 15 May 2001 17:30:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261573AbREOVaT>; Tue, 15 May 2001 17:30:19 -0400
Received: from [206.14.214.140] ([206.14.214.140]:6919 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S261559AbREOV2l>; Tue, 15 May 2001 17:28:41 -0400
Date: Tue, 15 May 2001 14:28:11 -0700 (PDT)
From: James Simmons <jsimmons@transvirtual.com>
To: Nicolas Pitre <nico@cam.org>
cc: "H. Peter Anvin" <hpa@transmeta.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        Alexander Viro <viro@math.psu.edu>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Neil Brown <neilb@cse.unsw.edu.au>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: LANANA: To Pending Device Number Registrants
In-Reply-To: <Pine.LNX.4.33.0105151713020.30128-100000@xanadu.home>
Message-ID: <Pine.LNX.4.10.10105151424161.22038-100000@www.transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Personally, I'd really like to see /dev/ttyS0 be the first detected serial
> port on a system, /dev/ttyS1 the second, etc.  Currently there are plenty of
> different serial hardware with all their own drivers and /dev entries.  For
> embedded systems with serial consoles, and also across architectures, this
> is a pain since the filesystem and namely /dev/inittab has to be adjusted
> for all different types of UARTs.  This is not the case for every different
> type of NICs and that's a good thing.

I couldn't agree with you more. It gives me headaches at work. One note,
their is a except to the eth0 thing. USB to USB networking. It uses usb0,
etc. I personally which they use eth0.  

