Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751184AbWAYOsG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751184AbWAYOsG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 09:48:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751185AbWAYOsF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 09:48:05 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:56543 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1751184AbWAYOsB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 09:48:01 -0500
Date: Wed, 25 Jan 2006 15:47:56 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Jens Axboe <axboe@suse.de>
cc: Joerg Schilling <schilling@fokus.fraunhofer.de>, matthias.andree@gmx.de,
       rlrevell@joe-job.com, linux-kernel@vger.kernel.org
Subject: Re: CD writing in future Linux (stirring up a hornets' nest) (was:
 Rationale for RLIMIT_MEMLOCK?)
In-Reply-To: <20060125142155.GW4212@suse.de>
Message-ID: <Pine.LNX.4.61.0601251544400.31234@yvahk01.tjqt.qr>
References: <20060123165415.GA32178@merlin.emma.line.org>
 <1138035602.2977.54.camel@laptopd505.fenrus.org> <20060123180106.GA4879@merlin.emma.line.org>
 <1138039993.2977.62.camel@laptopd505.fenrus.org> <20060123185549.GA15985@merlin.emma.line.org>
 <43D530CC.nailC4Y11KE7A@burner> <1138048255.21481.15.camel@mindpipe>
 <20060123212119.GI1820@merlin.emma.line.org> <Pine.LNX.4.61.0601241823390.28682@yvahk01.tjqt.qr>
 <43D78585.nailD7855YVBX@burner> <20060125142155.GW4212@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> And if you check the amount of completely unneeded code Linux currently has 
>> just to implement e.g. SG_IO in /dev/hd*, it could even _save_ space in the 
>> kernel when converting to a clean SCSI based design.
>
>Please point me at that huge amount of code. Hint: there is none.

I'm getting a grin:

15:46 takeshi:../drivers/ide > find . -type f -print0 | xargs -0 grep SG_IO
(no results)

Looks like it's already non-redundant :)



Jan Engelhardt
-- 
