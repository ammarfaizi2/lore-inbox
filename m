Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271287AbTHHLUE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 07:20:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271295AbTHHLUE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 07:20:04 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:4497 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S271287AbTHHLUA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 07:20:00 -0400
Date: Fri, 8 Aug 2003 13:19:58 +0200 (MEST)
Message-Id: <200308081119.h78BJwKP015664@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: B.Zolnierkiewicz@elka.pw.edu.pl
Subject: Re: ide-tape broken (was Re: [PATCH] use ide-identify.h, fix endian bug)
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Aug 2003 02:10:19 +0200 (MET DST), Bartlomiej Zolnierkiewicz wrote:
>> I'd rather use ide-scsi+st or a new clean ATAPI tape driver
>> than ide-tape.c. (I've studied ide-tape.c. It reeks of poor
>
>"new clean ATAPI tape drive" == the one yet to be written?

Correct.

>> coding style, kludges for Onstream, and an over-engineered
>> buffering scheme. And it's known to have problems with DMA.)
>
>So you are familiar with the code, cool. ;-)

Only as a generic coder trying to fix it, and as a user
looking at other people's bug reports.

/Mikael
