Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261535AbREOVV2>; Tue, 15 May 2001 17:21:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261547AbREOVVJ>; Tue, 15 May 2001 17:21:09 -0400
Received: from modemcable084.137-200-24.mtl.mc.videotron.ca ([24.200.137.84]:53756
	"EHLO xanadu.home") by vger.kernel.org with ESMTP
	id <S261535AbREOVU6>; Tue, 15 May 2001 17:20:58 -0400
Date: Tue, 15 May 2001 17:20:31 -0400 (EDT)
From: Nicolas Pitre <nico@cam.org>
X-X-Sender: <nico@xanadu.home>
To: James Simmons <jsimmons@transvirtual.com>
cc: "H. Peter Anvin" <hpa@transmeta.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        Alexander Viro <viro@math.psu.edu>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Neil Brown <neilb@cse.unsw.edu.au>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: LANANA: To Pending Device Number Registrants
In-Reply-To: <Pine.LNX.4.10.10105151326010.22038-100000@www.transvirtual.com>
Message-ID: <Pine.LNX.4.33.0105151713020.30128-100000@xanadu.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 15 May 2001, James Simmons wrote:

>
> > I actually suggested something like this a while ago, mainly w.r.t. how
> > to deal with serial ports (e.g. /dev/ttyS0/callout instead of /dev/cua0).
>
> Very brillant. I like to see this as well, plus include the other serial
> devices.

Personally, I'd really like to see /dev/ttyS0 be the first detected serial
port on a system, /dev/ttyS1 the second, etc.  Currently there are plenty of
different serial hardware with all their own drivers and /dev entries.  For
embedded systems with serial consoles, and also across architectures, this
is a pain since the filesystem and namely /dev/inittab has to be adjusted
for all different types of UARTs.  This is not the case for every different
type of NICs and that's a good thing.


Nicolas

