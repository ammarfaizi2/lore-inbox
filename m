Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129792AbQLKArv>; Sun, 10 Dec 2000 19:47:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130511AbQLKArm>; Sun, 10 Dec 2000 19:47:42 -0500
Received: from obelix.hrz.tu-chemnitz.de ([134.109.132.55]:35260 "EHLO
	obelix.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S129792AbQLKArg>; Sun, 10 Dec 2000 19:47:36 -0500
Date: Mon, 11 Dec 2000 02:16:52 +0100
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: Frank Davis <fdavis112@juno.com>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: test12-pre8 ohci1394.c compile error
Message-ID: <20001211021652.J7554@nightmaster.csn.tu-chemnitz.de>
In-Reply-To: <381711807.976492925796.JavaMail.root@web340-wra.mail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <381711807.976492925796.JavaMail.root@web340-wra.mail.com>; from fdavis112@juno.com on Sun, Dec 10, 2000 at 07:02:05PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 10, 2000 at 07:02:05PM -0500, Frank Davis wrote:
> ohci1394.c:1588: structure has no member named 'next'
> make[2]:*** [ohci1394.o] Error 1
> make[2]: Leaving directory '/usr/src/linux/drivers/ieee1394'
> ....
> Its the same case with drivers/i2o/i2o_lan.c
> 
> I suspect there are more. Is there a simple patch that will fix all affected drivers?

Working on it. I _need_ pre8, because of some critical fixes in
it.

<RANT>
Whoever changed this interface without fixing _all_ the offending
files, should be shot^W^Wthink about the meaning of the words

                          CODE FREEZE
for at least one week.
</RANT>

Sorry, but this had to be said ;-)

But heh, we all make mistakes sometimes.

Regards

Ingo Oeser
-- 
10.+11.03.2001 - 3. Chemnitzer LinuxTag <http://www.tu-chemnitz.de/linux/tag>
         <<<<<<<<<<<<       come and join the fun       >>>>>>>>>>>>
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
