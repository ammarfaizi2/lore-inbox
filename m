Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264260AbUHJKax@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264260AbUHJKax (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 06:30:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263893AbUHJKax
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 06:30:53 -0400
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:47566 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S264260AbUHJK2u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 06:28:50 -0400
Date: Tue, 10 Aug 2004 12:27:56 +0200 (CEST)
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Message-Id: <200408101027.i7AARuZr012065@burner.fokus.fraunhofer.de>
To: dwmw2@infradead.org, schilling@fokus.fraunhofer.de
Cc: James.Bottomley@steeleye.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de,
       eric@lammerts.org, linux-kernel@vger.kernel.org
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>From: David Woodhouse <dwmw2@infradead.org>

>> Cdrecord also needs privilleges to lock memory and to raise prioirity.

>Wrong. Cdrecord does not always _need_ to lock memory or to raise its
>priority.

>To do so may be useful when using older drives without buffer underrun
>protection, but is not strictly necessary on current hardware. 

Please inform yourself before posting.....

Burn-Proof is switched off by default and other protections (invented later)
are switched off by cdrecord to get compatibility..... if you only had read the 
man page......

Switching Burn-Proof on will reduce the quality of the CDs.


In addition: if you don't have the experience when Buffer Underruns occur, you 
should not post speculations that it is not a problem. I know that it _is_ and 
this should be enough for you. Unless you send me the results from a test done 
under worst conditions you need to believe in the experience of people who 
spend more time on CD/DVD recording issues than you.

Proving things to work for a 1/12th dozen only is not sufficient for granting 
quality.

Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de		(uni)  If you don't have iso-8859-1
       schilling@fokus.fraunhofer.de	(work) chars I am J"org Schilling
 URL:  http://www.fokus.fraunhofer.de/usr/schilling ftp://ftp.berlios.de/pub/schily
