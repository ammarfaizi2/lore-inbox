Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129210AbQLEQuO>; Tue, 5 Dec 2000 11:50:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129744AbQLEQuF>; Tue, 5 Dec 2000 11:50:05 -0500
Received: from Cantor.suse.de ([194.112.123.193]:45327 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S129210AbQLEQt4>;
	Tue, 5 Dec 2000 11:49:56 -0500
Date: Tue, 5 Dec 2000 17:19:32 +0100
From: Jens Axboe <axboe@suse.de>
To: Roderich Schupp <rsch@ExperTeam.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Problems with CDROMVOLCTRL
Message-ID: <20001205171932.C379@suse.de>
In-Reply-To: <200012031330.OAA04450@www1.ExperTeam.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200012031330.OAA04450@www1.ExperTeam.de>; from rsch@ExperTeam.de on Sun, Dec 03, 2000 at 02:25:02PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 03 2000, Roderich Schupp wrote:
> Hi,
> CDROMVOLCTRL does not work with my configuration in test11.
> The ioctl always returns an error and volume stays the same
> (seen with xmcd and gtcd). I tried the patch at
> 
> *.kernel.org/pub/linux/kernel/people/axboe/patches/2.4.0-test11/cd-1.bz2
> 
> This changed the error code from some bogus large positive number
> to -EOPNOTSUPP :) However, volume control works fine in 2.2.17,
> so the hardware shouldn't be the culprit.
> The cdrom drive in question is an old TEAC CD-56S on an 
> Adaptec AHA-2940 (narrow) controller.

Please send me contents of /proc/sys/dev/cdrom/info and the sr
load info.

-- 
* Jens Axboe <axboe@suse.de>
* SuSE Labs
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
