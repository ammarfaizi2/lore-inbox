Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267370AbUHEM6k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267370AbUHEM6k (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 08:58:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267659AbUHEM5K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 08:57:10 -0400
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:40446 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S266686AbUHEMuQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 08:50:16 -0400
Date: Thu, 5 Aug 2004 14:49:36 +0200 (CEST)
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Message-Id: <200408051249.i75CnasZ004533@burner.fokus.fraunhofer.de>
To: axboe@suse.de, schilling@fokus.fraunhofer.de
Cc: kernel@wildsau.enemy.org, linux-kernel@vger.kernel.org
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>From: Jens Axboe <axboe@suse.de>

>> Let me give you an advise: consolidate Linux so that is does only need
>> /dev/sg and fix the bugs in ide-scsi instead of constantly inventing new
>> unneeded interfaces.

>That's been the general direction for quite some time, just that SG_IO
>is the preferred method since that works all around. You were the one
>that merged support for the CDROM_SEND_PACKET interface, which has
>_never_ been advertised as a way to burn CDs in Linux. I'd suggest you
>remove that.

Again:

I'd be happy to start a discussion on this topic after the problem 
with kernel panic() or general unusability with ide-scsi for PC-card
or PCMCIA connected drives has been fixed for Linux-2.4 and all kernels
outside have been replaced by working ones...

I reported this problem to the end of y2000, this is long time ago.

Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de		(uni)  If you don't have iso-8859-1
       schilling@fokus.fraunhofer.de	(work) chars I am J"org Schilling
 URL:  http://www.fokus.fraunhofer.de/usr/schilling ftp://ftp.berlios.de/pub/schily
