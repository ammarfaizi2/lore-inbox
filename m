Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261989AbUCSRHN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Mar 2004 12:07:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262345AbUCSRHN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Mar 2004 12:07:13 -0500
Received: from chaos.analogic.com ([204.178.40.224]:10127 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261989AbUCSRGo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Mar 2004 12:06:44 -0500
Date: Fri, 19 Mar 2004 12:09:04 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Tigran Aivazian <tigran@aivazian.fsnet.co.uk>
cc: "Randy.Dunlap" <rddunlap@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: CDFS
In-Reply-To: <Pine.LNX.4.44.0403191640460.3892-100000@einstein.homenet>
Message-ID: <Pine.LNX.4.53.0403191200120.3752@chaos>
References: <Pine.LNX.4.44.0403191640460.3892-100000@einstein.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Mar 2004, Tigran Aivazian wrote:

> On Fri, 19 Mar 2004, Richard B. Johnson wrote:
>
> > On Fri, 19 Mar 2004, Randy.Dunlap wrote:
> >
> > > On Fri, 19 Mar 2004 11:01:44 -0500 (EST) Richard B. Johnson wrote:
> > >
> > > |
> > > | Just got a CD/ROM that 'works' on W$, but not Linux.
> > > | W$ `properties` call it 'CDFS'. Is there any such Linux
> > > | support?
> > >
> > > You did try to search for it, right?
> > >
> >
> > Sure did and what I get was an explaination that, for
> > Linux, the letters "CDFS" refer to something that "exports
> > all the tracks and boot images of a CD as normal files".
> >
> > That's not what I want. I want to mount a CDFS file-system.
> >
> > Given that, maybe the explaination is bogus, but I
> > need some CDFS file-system support so I can mount
> > a Microsoft CDFS CD/ROM. If such support exists, I
> > would think that I should be able to do:
> >
> > mount -t cdfs /dev/cdrom /mnt
>
> Unless something has changed seriously in just a few years, the name CDFS
> was always just a Microsoft synonym for the proper name iso9660. The Linux
> name CDFS is the filesystem which Randy pointed you at, for mounting
> multi-session CDs and accessing individual sessions as files (iso images).
>

Mounting it as an iso9660 fs doesn't work.

> So, if you have what Microsoft calls CDFS then it is simply iso9660 and if
> it doesn't mount then either your CD is damaged (and you only get a false
> "impression" of it working in Windows) or there is a bug in Linux iso9660
> implementation. What are the error messages you get when you try to mount
> it as an iso9660?


Script started on Fri Mar 19 12:01:38 2004
# umount /mnt
# umount /mnt
umount: /mnt: not mounted
# umount -t iso9660 /dev/cdrom /mnt
mount: wrong fs type, bad option, bad superblock on /dev/cdrom,
       or too many mounted file systems
# exit
Script done on Fri Mar 19 12:04:49 2004

>
> (You didn't forget to compile Joliet and RR extensions into your kernel,
> did you?)

Nope.

>
> Kind regards
> Tigran
>

Cheers,
Dick Johnson
Penguin : Linux version 2.4.24 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


