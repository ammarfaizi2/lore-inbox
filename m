Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312681AbSFTJQY>; Thu, 20 Jun 2002 05:16:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312973AbSFTJQX>; Thu, 20 Jun 2002 05:16:23 -0400
Received: from [195.63.194.11] ([195.63.194.11]:37129 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S312681AbSFTJQW> convert rfc822-to-8bit; Thu, 20 Jun 2002 05:16:22 -0400
Message-ID: <3D119D5B.8060202@evision-ventures.com>
Date: Thu, 20 Jun 2002 11:16:11 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0.0) Gecko/20020611
X-Accept-Language: pl, en-us
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Paul Bristow <paul@paulbristow.net>,
       Gadi Oxman <gadio@netvision.net.il>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.5.22] simple ide-tape.c and ide-floppy.c cleanup
References: <Pine.SOL.4.30.0206192338490.18992-200000@mion.elka.pw.edu.pl> <20020620054230.GK812@suse.de>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

U¿ytkownik Jens Axboe napisa³:
> On Wed, Jun 19 2002, Bartlomiej Zolnierkiewicz wrote:
> 
> Looks pretty good in general, just one minor detail:
> 
> 
>>+
>>+/*
>>+ *	ATAPI packet commands.
>>+ */
>>+#define ATAPI_FORMAT_UNIT_CMD		0x04
>>+#define ATAPI_INQUIRY_CMD		0x12
> 
> 
> [snip]
> 
> We already have the "full" list in cdrom.h (GPCMD_*), so lets just use
> that. After all, ATAPI_MODE_SELECT10_CMD _is_ the same as the SCSI
> variant (and I think the _CMD post fixing is silly, anyone familiar with
> this is going to know what ATAPI_WRITE10 means just fine)
> 
> Same for request_sense, that is already generalized in cdrom.h as well.

I wonder what FreeBSD is using here? I see no need for invention at
this place.

