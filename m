Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268013AbUHXPj2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268013AbUHXPj2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 11:39:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268004AbUHXPj2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 11:39:28 -0400
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:35838 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S268059AbUHXPfX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 11:35:23 -0400
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Date: Tue, 24 Aug 2004 17:34:11 +0200
To: schilling@fokus.fraunhofer.de, Kai.Makisara@kolumbus.fi
Cc: linux-kernel@vger.kernel.org, der.eremit@email.de, christer@weinigel.se,
       axboe@suse.de
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
Message-ID: <412B5FF3.nailBTB61UTSR@burner>
References: <2ptdY-42Y-55@gated-at.bofh.it>
 <2uPdM-380-11@gated-at.bofh.it> <2uUwL-6VP-11@gated-at.bofh.it>
 <2uWfh-8jo-29@gated-at.bofh.it> <2uXl0-Gt-27@gated-at.bofh.it>
 <2vge2-63k-15@gated-at.bofh.it> <2vgQF-6Ai-39@gated-at.bofh.it>
 <2vipq-7O8-15@gated-at.bofh.it> <2vj2b-8md-9@gated-at.bofh.it>
 <2vDtS-bq-19@gated-at.bofh.it> <E1ByXMd-00007M-4A@localhost>
 <412770EA.nail9DO11D18Y@burner> <412889FC.nail9MX1X3XW5@burner>
 <Pine.LNX.4.58.0408221450540.297@neptune.local>
 <m37jrr40zi.fsf@zoo.weinigel.se> <4128CAA2.nail9RG21R1OG@burner>
 <Pine.LNX.4.58.0408232113030.4258@kai.makisara.local>
In-Reply-To: <Pine.LNX.4.58.0408232113030.4258@kai.makisara.local>
User-Agent: nail 11.2 8/15/04
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kai Makisara <Kai.Makisara@kolumbus.fi> wrote:

> > BTW: 'mt' should not need to send SCSI comands. THis shoul dbe handled via
> > specilized ioctls.
> > 
> There are already ioctls for changing the tape parameters. Christer, there 
> is no need to introduce tapes into this discussion.

This is my words....


Tape drives have a well known and simple and standardized interface since many
years (> 40). There exist ioctl()s to do anything you like.


CD/DVD writing ist still constantly evolving, so you cannot have it in the 
kernel.

BTW: I am strongly against any list of "safe commands" as this would only make 
things more complicated. Things that control security should be ket simple.

Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de		(uni)  If you don't have iso-8859-1
       schilling@fokus.fraunhofer.de	(work) chars I am J"org Schilling
 URL:  http://www.fokus.fraunhofer.de/usr/schilling ftp://ftp.berlios.de/pub/schily
