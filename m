Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262481AbVBCILw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262481AbVBCILw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 03:11:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262799AbVBCILw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 03:11:52 -0500
Received: from smtp.sys.beep.pl ([195.245.198.13]:15882 "EHLO smtp.sys.beep.pl")
	by vger.kernel.org with ESMTP id S262481AbVBCILk convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 03:11:40 -0500
From: Arkadiusz Miskiewicz <arekm@pld-linux.org>
Organization: SelfOrganizing
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] radeonfb update (new patch)
Date: Thu, 3 Feb 2005 09:11:39 +0100
User-Agent: KMail/1.7.2
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
References: <1107411557.2189.24.camel@gaston> <20050202222729.72ad31d4.akpm@osdl.org> <1107412690.2362.33.camel@gaston>
In-Reply-To: <1107412690.2362.33.camel@gaston>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200502030911.39609.arekm@pld-linux.org>
X-Authenticated-Id: arekm 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 03 of February 2005 07:38, Benjamin Herrenschmidt wrote:

> > Are you seriously proposing this for 2.6.11??
>
> Well... There should be no problem with
> add-try_acquire_console_sem.patch and
> update-aty128fb-sleep-wakeup-code-for-new-powermac-changes.patch.
>
> radeonfb is another story, but the newer patch is definitely less
> invasive. It really just fixes bugs and adds the bulk of PM stuff to
> wakeup the newer chips, plus some backlight changes. It's been tested by
> pmac users for a while, the only reason I sent it to you only recently
> is that i was away for a month !
,,backlight changes'' - that interests me. My ibook g4 1.2GHz right now can 
sleep and wake up sometimes (with additional patch) but the backlight doesn't 
turn on or is very, very dark and I can't make it lighter from keyboard. Is 
this change related to such problems?

Generic question - how does suspend to ram/suspend to disk looks for ibook g4 
in current Linus and mm kernels?

> I'm hesitating about having it in 2.6.11 tho due to linus wanting to
> release real soon, I'd rather have a bit more non-ppc testing just in
> case though... but now it depends entirely on when linus plans to get
> 2.6.11 out of the door.
>
> Ben.

-- 
Arkadiusz Mi¶kiewicz                    PLD/Linux Team
http://www.t17.ds.pwr.wroc.pl/~misiek/  http://ftp.pld-linux.org/
