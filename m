Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316235AbSGNMnh>; Sun, 14 Jul 2002 08:43:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316434AbSGNMng>; Sun, 14 Jul 2002 08:43:36 -0400
Received: from mailhub.fokus.gmd.de ([193.174.154.14]:28918 "EHLO
	mailhub.fokus.gmd.de") by vger.kernel.org with ESMTP
	id <S316235AbSGNMnf>; Sun, 14 Jul 2002 08:43:35 -0400
Date: Sun, 14 Jul 2002 14:44:53 +0200 (CEST)
From: Joerg Schilling <schilling@fokus.gmd.de>
Message-Id: <200207141244.g6ECir4j019051@burner.fokus.gmd.de>
To: linux-kernel@vger.kernel.org
Subject: Re: IDE/ATAPI in 2.5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H. Peter Anvin wrote:

I'm talking specifically about ATAPI devices here.  As we have already 
covered, not all ATA devices are ATAPI, but unless I'm completely off 
the wall, ATAPI is SCSI over IDE, and should be able to be driven as 
such.  The lack of access to that interface using the established 
interface mechanisms just bites.

You fund it!

Other people did not even think about the problem, or even lack the 
needed knowledge.

Alan Cox is one of the latter ones :-( he only tries to avoid needed
changes ithout any technical reason.

If you have a IDE based CD-ROM drive that does not support ATAPI,
why not handle it the only way it makes sense?

Such a drive is no more than a read-only hard disk and may be accessed
via the HD IDE read interface. You will never be able to use it 
to e.g. rip audio data off it.

If there really is a poor school that cannot afford to buy a modern
20-30 Euro CD-ROM drive, then this school can liveas long as they 
are able to install the OS from the old (1992) CD-ROM they currently own.



Jörg

 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de		(uni)  If you don't have iso-8859-1
       schilling@fokus.gmd.de		(work) chars I am J"org Schilling
 URL:  http://www.fokus.gmd.de/usr/schilling   ftp://ftp.fokus.gmd.de/pub/unix
