Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265285AbSK1JCk>; Thu, 28 Nov 2002 04:02:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265306AbSK1JCk>; Thu, 28 Nov 2002 04:02:40 -0500
Received: from angband.namesys.com ([212.16.7.85]:50818 "HELO
	angband.namesys.com") by vger.kernel.org with SMTP
	id <S265285AbSK1JCj>; Thu, 28 Nov 2002 04:02:39 -0500
Date: Thu, 28 Nov 2002 12:09:59 +0300
From: Oleg Drokin <green@namesys.com>
To: Sonke Ruempler <ruempler@topconcepts.com>
Cc: linux-kernel@vger.kernel.org, reiserfs-list@namesys.com
Subject: Re: reiserfs bug
Message-ID: <20021128120959.A2904@namesys.com>
References: <072801c296b8$2cb01000$6600a8c0@topconcepts.net> <20021128114755.A2724@namesys.com> <077201c296bb$43b4ac40$6600a8c0@topconcepts.net> <20021128115708.A2792@namesys.com> <079a01c296bd$1d51f150$6600a8c0@topconcepts.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <079a01c296bd$1d51f150$6600a8c0@topconcepts.net>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Thu, Nov 28, 2002 at 10:04:10AM +0100, Sonke Ruempler wrote:
> > Sorry, but you seems to have faulty hardware (bad harddrive or something).
> > Reiserfs cannot tolerate bad blocks in journal area right now.
> > I'd suggest you to make a backup of your device and then to replace bad
> > harddrive.
> umm, that are originally freecom 20gig ide hdds in a firewire-case, i
> replaced the hdds with 120gig maxtor hdds and they worked for 2 weeks until
> today.
> maybe the firewire<->ide converter is corrupted?

I do not know. Your log indicates that your scsi subsystem encountered errors.
But I do not know actual source of errors. May be if you enable more verbose
scsi errors reporting it will give you some clue. (like what command
failed, what was the error code and this kind of stuff).

Bye,
    Oleg
