Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268015AbUHEWY4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268015AbUHEWY4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 18:24:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268031AbUHEWYf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 18:24:35 -0400
Received: from web52902.mail.yahoo.com ([206.190.39.179]:5717 "HELO
	web52902.mail.yahoo.com") by vger.kernel.org with SMTP
	id S268025AbUHEWT7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 18:19:59 -0400
Message-ID: <20040805221952.31315.qmail@web52902.mail.yahoo.com>
Date: Fri, 6 Aug 2004 00:19:52 +0200 (CEST)
From: =?iso-8859-1?q?szonyi=20calin?= <caszonyi@yahoo.com>
Subject: Re: Linux 2.6.8-rc3
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <87657xtyd3.fsf@devron.myhome.or.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 --- OGAWA Hirofumi <hirofumi@mail.parknet.co.jp> a écrit : 
> Erik Mouw <erik@harddisk-recovery.com> writes:
> 
> > >        iocharset=value
> > >               Character set to use for converting between
> 8 bit characters and
> > >               16 bit Unicode characters. The default is
> iso8859-1.  Long file-
> > >               names are stored on disk in Unicode format.
> > > 
> > > the default is iso8859-1. Has this default gone haywire
> somewhere?
> > 
> > Yes, it's in the hidden in the ChangeLog. You can find it if
> you know
> > iocharset is the same as nls:
> > 
> >   Hirofumi Ogawa:
> >     o FAT: kill nls default
> 
> Or Documentation/filesystems/vfat.txt

kernel says

FAT: codepage or iocharset option didn't specified
     File name can not access proper (mounted as read-only)

codepage *is* specified:
my fstab line for mounting the vfat filesystem is:
/dev/hda1       /mnt/dosc        vfat       
defaults,user,uid=100,gid=100,codepage=437         1   0

So the message is not correct ;-)
specifying iocharset works.

Bye
Calin

--
Yesterday it worked
today isn't working
windows is like that 


	

	
		
Vous manquez d’espace pour stocker vos mails ? 
Yahoo! Mail vous offre GRATUITEMENT 100 Mo !
Créez votre Yahoo! Mail sur http://fr.benefits.yahoo.com/

Le nouveau Yahoo! Messenger est arrivé ! Découvrez toutes les nouveautés pour dialoguer instantanément avec vos amis. A télécharger gratuitement sur http://fr.messenger.yahoo.com
