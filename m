Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262202AbTJSWAX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Oct 2003 18:00:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262243AbTJSWAX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Oct 2003 18:00:23 -0400
Received: from imap.gmx.net ([213.165.64.20]:59526 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262202AbTJSWAT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Oct 2003 18:00:19 -0400
Date: Mon, 20 Oct 2003 00:00:17 +0200 (MEST)
From: "Svetoslav Slavtchev" <svetljo@gmx.de>
To: "Tomi Orava" <Tomi.Orava@ncircle.nullnet.fi>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
References: <34569.192.168.9.10.1066600317.squirrel@ncircle.nullnet.fi>
Subject: Re: HighPoint 374
X-Priority: 3 (Normal)
X-Authenticated: #20183004
Message-ID: <31062.1066600817@www23.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> > i have the same problems with epox 8k9a3+,
> > and may be even strange ones
> > (like fs coruption when soft raid & / or lvm is used)
> 
> I've seen the filesystem corruption with ext3 & xfs
> and RAID1 (md) as well. However, I don't seem to
> be able to get that far nowadays, as the machine
> is being used as NFS-server and thefore there is
> always "too much" disk-transfers going on and an
> IDE-system hang happens quite soon after boot.
> (it seems that my raid-disks get out of sync every time
> I switch from proprietary driver --> kernel driver
> and so it might be the raid resync that hangs the system).

i tested xfs/reiserfs & may be ext2 & jfs
both on plain(and with lvm over md)  soft raid 0/1/5
never tried the closed source drivers

> > and i never had the problems with 8k5a3+,
> > the drives were actually taken from the 8k5a3+
> > when it died (me silly tried to update to XP2700)
> >
> > really strange, isn't it
> >
> > both boards should be the same, except
> > 8k5a3+ uses kt333
> > 8k9a3+ uses kt400
> 
> Yep, but it cannot be strictly via-chipset issue
> as I have verified that the same problem exists
> with Epox 4PCA3+ motherboard, which is P4 & Intel 875P
> based.

may be a certain HPT BIOS version ?

i'll reboot to check what's here 

svetljo

-- 
NEU FÜR ALLE - GMX MediaCenter - für Fotos, Musik, Dateien...
Fotoalbum, File Sharing, MMS, Multimedia-Gruß, GMX FotoService

Jetzt kostenlos anmelden unter http://www.gmx.net

+++ GMX - die erste Adresse für Mail, Message, More! +++

