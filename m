Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261559AbREOVc2>; Tue, 15 May 2001 17:32:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261575AbREOVcS>; Tue, 15 May 2001 17:32:18 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:51466 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261559AbREOVcH>; Tue, 15 May 2001 17:32:07 -0400
Message-ID: <3B01A044.F72BFDD1@transmeta.com>
Date: Tue, 15 May 2001 14:31:48 -0700
From: "H. Peter Anvin" <hpa@transmeta.com>
Organization: Transmeta Corporation
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.5-pre1-zisofs i686)
X-Accept-Language: en, sv, no, da, es, fr, ja
MIME-Version: 1.0
To: James Simmons <jsimmons@transvirtual.com>
CC: Nicolas Pitre <nico@cam.org>, Linus Torvalds <torvalds@transmeta.com>,
        Alexander Viro <viro@math.psu.edu>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Neil Brown <neilb@cse.unsw.edu.au>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: LANANA: To Pending Device Number Registrants
In-Reply-To: <Pine.LNX.4.10.10105151424161.22038-100000@www.transvirtual.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Simmons wrote:
> 
> > Personally, I'd really like to see /dev/ttyS0 be the first detected serial
> > port on a system, /dev/ttyS1 the second, etc.  Currently there are plenty of
> > different serial hardware with all their own drivers and /dev entries.  For
> > embedded systems with serial consoles, and also across architectures, this
> > is a pain since the filesystem and namely /dev/inittab has to be adjusted
> > for all different types of UARTs.  This is not the case for every different
> > type of NICs and that's a good thing.
> 
> I couldn't agree with you more. It gives me headaches at work. One note,
> their is a except to the eth0 thing. USB to USB networking. It uses usb0,
> etc. I personally which they use eth0.
> 

"ethX" is only used for Ethernet.  Other types of network devices use
other names.

Personally, I would also like to see network devices manifest in the
filesystem namespace like everything else.

	-=hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
