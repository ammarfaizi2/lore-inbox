Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312419AbSDEJtH>; Fri, 5 Apr 2002 04:49:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312426AbSDEJs6>; Fri, 5 Apr 2002 04:48:58 -0500
Received: from sproxy.gmx.de ([213.165.64.20]:58163 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S312419AbSDEJsl>;
	Fri, 5 Apr 2002 04:48:41 -0500
Date: Fri, 5 Apr 2002 11:48:29 +0200
From: Sebastian Droege <sebastian.droege@gmx.de>
To: Greg KH <greg@kroah.com>
Cc: davej@suse.de, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.5.7-dj3 - BUG & PATCH
Message-Id: <20020405114829.62111b5d.sebastian.droege@gmx.de>
In-Reply-To: <20020405064545.GA19248@kroah.com>
X-Mailer: Sylpheed version 0.7.4 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 boundary="=.+7Vj)MPEY7+D'w"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=.+7Vj)MPEY7+D'w
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 4 Apr 2002 22:45:45 -0800
Greg KH <greg@kroah.com> wrote:

> On Thu, Apr 04, 2002 at 05:22:38PM +0200, Sebastian Droege wrote:
> > Hi,
> > I have a problem in 2.5.7-dj3 which doesn't exist in 2.5.8-pre1...
> > My USB keyboard and mouse are detected properly but aren't usable
> > I get the same behaviour when unsetting CONFIG_USB_HIDINPUT in 2.5.8-pre1
> > grepping for CONFIG_USB_HIDINPUT in 2.5.7-dj3 finds something but the option doesn't show in old/menuconfig
> > When setting CONFIG_USB_HIDINPUT=y by hand in 2.5.7-dj3 I get a compile error:
> > 
> > make[3]: Entering directory `/usr/src/linux-2.5.7/drivers/usb'
> > gcc -D__KERNEL__ -I/usr/src/linux-2.5.7/include -Wall -Wstrict-prototypes -Wno-trigraphs -O6 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686   -DKBUILD_BASENAME=hid_input  -c -o hid-input.o hid-input.c
> > hid-input.c:335: redefinition of `hidinput_hid_event'
> > hid.h:411: `hidinput_hid_event' previously defined here
> > hid-input.c:413: redefinition of `hidinput_connect'
> > hid.h:412: `hidinput_connect' previously defined here
> > hid-input.c:458: redefinition of `hidinput_disconnect'
> > hid.h:413: `hidinput_disconnect' previously defined here
> > make[3]: *** [hid-input.o] Fehler 1
> 
> I can't duplicate this, can you send me your .config?
Sure but I can't reproduce it either with a clean tree
Strange... but I have done a make mrproper in the old tree and the compile error was still there...

Bye
--=.+7Vj)MPEY7+D'w
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)

iD8DBQE8rXL0e9FFpVVDScsRAnQpAKDZtJ1pNxR8U8cc5aJ7MezNHPAI5ACg1EcH
P3SqU/8+3etTp3vvGd5f9ic=
=a7XN
-----END PGP SIGNATURE-----

--=.+7Vj)MPEY7+D'w--

