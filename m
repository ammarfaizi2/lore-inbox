Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317263AbSH0UoV>; Tue, 27 Aug 2002 16:44:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317298AbSH0UoV>; Tue, 27 Aug 2002 16:44:21 -0400
Received: from sproxy.gmx.de ([213.165.64.20]:35612 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S317263AbSH0UoL>;
	Tue, 27 Aug 2002 16:44:11 -0400
From: Felix Seeger <felix.seeger@gmx.de>
To: Greg KH <greg@kroah.com>
Subject: Re: USB mouse problem, kernel panic on startup in 2.4.19
Date: Tue, 27 Aug 2002 22:48:07 +0200
User-Agent: KMail/1.4.6
Cc: linux-kernel@vger.kernel.org
References: <200208272011.51691.felix.seeger@gmx.de> <200208272130.14728.felix.seeger@gmx.de> <20020827193632.GD23865@kroah.com>
In-Reply-To: <20020827193632.GD23865@kroah.com>
MIME-Version: 1.0
Content-Description: clearsigned data
Content-Disposition: inline
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <200208272248.10846.felix.seeger@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Am Dienstag, 27. August 2002 21:36 schrieb Greg KH:
> On Tue, Aug 27, 2002 at 09:30:11PM +0200, Felix Seeger wrote:
> > No, sorry. Doesn't help.
> > Is that a patch for 2.4.20-pre4 ? I am using 2.4.19.
>
> Yes it is, but it might apply to 2.4.19.  I am guessing you tried it,
> and it applied cleanly?  Any build errors?
Yes I tried it and there were no build errors. Only a message during the 
patch.

I copied the patch to the top level kernel dir.
Than I've done a "patch -p1 < patchfile"

I get this:
patching file drivers/usb/usb-ohci.c
Hunk #3 succeeded at 2285 (offset -13 lines).

After that: make dep, make bzImage, make modules, make modules install, copy, 
lilo

Something I fogot:
If I put the mouse in the problematic port after startup, everything works 
fine.

> > Oh, the shift and the numlock leds are blinking.
>
> That means the kernel paniced :)

Nice feature

> thanks,
>
> greg k-h


have fun
Felix
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9a+WKS0DOrvdnsewRAgoAAJ4i9FPy+7HI674Zn9VHTXF9qf54aQCeIOo5
h54EAjXg0VF0rrTHu+pF4Dk=
=xpHA
-----END PGP SIGNATURE-----

