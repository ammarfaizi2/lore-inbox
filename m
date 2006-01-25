Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751209AbWAYP13@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751209AbWAYP13 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 10:27:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751226AbWAYP13
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 10:27:29 -0500
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:5609 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S1751209AbWAYP13 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 10:27:29 -0500
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Date: Wed, 25 Jan 2006 16:26:23 +0100
To: matthias.andree@gmx.de, jengelh@linux01.gwdg.de
Cc: schilling@fokus.fraunhofer.de, rlrevell@joe-job.com,
       linux-kernel@vger.kernel.org
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <43D7989F.nailD789192N3@burner>
References: <1138014312.2977.37.camel@laptopd505.fenrus.org>
 <20060123165415.GA32178@merlin.emma.line.org>
 <1138035602.2977.54.camel@laptopd505.fenrus.org>
 <20060123180106.GA4879@merlin.emma.line.org>
 <1138039993.2977.62.camel@laptopd505.fenrus.org>
 <20060123185549.GA15985@merlin.emma.line.org>
 <43D530CC.nailC4Y11KE7A@burner> <1138048255.21481.15.camel@mindpipe>
 <20060123212119.GI1820@merlin.emma.line.org>
 <Pine.LNX.4.61.0601241823390.28682@yvahk01.tjqt.qr>
 <20060124181813.GA30863@merlin.emma.line.org>
 <Pine.LNX.4.61.0601242151520.17164@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0601242151520.17164@yvahk01.tjqt.qr>
User-Agent: nail 11.2 8/15/04
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt <jengelh@linux01.gwdg.de> wrote:

> Where is the difference between SG_IO-on-hdx and sg0?

-	Accessing _all_ SCSI devices from a unique name space.

-	Using a driver that if located at the right layering level
	(just above the transport) but not at the block level where 
	SCSI transport does not belong.

-	Cutting down kernel size by avoiding multiple implemenations
	of code for the same purpose.

There are of course more....



Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de                (uni)  
       schilling@fokus.fraunhofer.de     (work) Blog: http://schily.blogspot.com/
 URL:  http://cdrecord.berlios.de/old/private/ ftp://ftp.berlios.de/pub/schily
