Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261411AbTJTHnw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 03:43:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262004AbTJTHnw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 03:43:52 -0400
Received: from ncircle.nullnet.fi ([62.236.96.207]:62700 "EHLO
	ncircle.nullnet.fi") by vger.kernel.org with ESMTP id S261411AbTJTHnv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 03:43:51 -0400
Message-ID: <17073.194.237.142.24.1066635813.squirrel@ncircle.nullnet.fi>
In-Reply-To: <20031020064831.GT1128@suse.de>
References: <Pine.LNX.4.10.10310191329150.15306-100000@master.linux-ide.org>
    <200310192251.46159.bzolnier@elka.pw.edu.pl>
    <20031020064831.GT1128@suse.de>
Date: Mon, 20 Oct 2003 10:43:33 +0300 (EEST)
Subject: Re: HighPoint 374
From: "Tomi Orava" <Tomi.Orava@ncircle.nullnet.fi>
To: "Jens Axboe" <axboe@suse.de>
Cc: "Bartlomiej Zolnierkiewicz" <b.zolnierkiewicz@elka.pw.edu.pl>,
       "Andre Hedrick" <andre@linux-ide.org>,
       "Svetoslav Slavtchev" <svetljo@gmx.de>, linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.2
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> On Sun, Oct 19 2003, Bartlomiej Zolnierkiewicz wrote:
>>
>> Andre, thanks for helpful hint.
>> Svetoslav, the right person to whine about TCQ stuff is Jens Axboe 8-).
>
> Well that's correct, but this looks more like an AS iosched bug :)

Pardon my ignorance, but what is this AS iosched ?

>> > You do not enable TCQ on highpoint without using the hosted polling
>> timer.
>> > Oh and I have not added it, and so hit Bartlomiej up for the
>> additions.
>
> For what? TCQ tests fine on a HPT370 here.

I'm not entirely sure if that proves something or not,
as the whole (interrupt & hang) problem seems to exist
only with HPT374 and not with any other version of the chip anyway.
I do personally have one mb with a 372-chip and it has always
worked just fine with this same driver (perhaps its harder
to detect the problem with only two disks?).

Regards,
Tomi Orava


