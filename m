Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261601AbREOVoI>; Tue, 15 May 2001 17:44:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261600AbREOVoC>; Tue, 15 May 2001 17:44:02 -0400
Received: from quattro.sventech.com ([205.252.248.110]:22798 "HELO
	quattro.sventech.com") by vger.kernel.org with SMTP
	id <S261601AbREOVnl>; Tue, 15 May 2001 17:43:41 -0400
Date: Tue, 15 May 2001 17:43:40 -0400
From: Johannes Erdfelt <johannes@erdfelt.com>
To: James Simmons <jsimmons@transvirtual.com>
Cc: Nicolas Pitre <nico@cam.org>, "H. Peter Anvin" <hpa@transmeta.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        Alexander Viro <viro@math.psu.edu>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Neil Brown <neilb@cse.unsw.edu.au>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: LANANA: To Pending Device Number Registrants
Message-ID: <20010515174339.A5599@sventech.com>
In-Reply-To: <Pine.LNX.4.33.0105151713020.30128-100000@xanadu.home> <Pine.LNX.4.10.10105151424161.22038-100000@www.transvirtual.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.4i
In-Reply-To: <Pine.LNX.4.10.10105151424161.22038-100000@www.transvirtual.com>; from James Simmons on Tue, May 15, 2001 at 02:28:11PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 15, 2001, James Simmons <jsimmons@transvirtual.com> wrote:
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

USB to USB networking cables aren't ethernet.

There are USB to ethernet adapters and they do appear as eth0.

JE

