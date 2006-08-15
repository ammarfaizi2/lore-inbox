Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965017AbWHOMdx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965017AbWHOMdx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 08:33:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932527AbWHOMdx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 08:33:53 -0400
Received: from hobbit.corpit.ru ([81.13.94.6]:15956 "EHLO hobbit.corpit.ru")
	by vger.kernel.org with ESMTP id S932328AbWHOMdx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 08:33:53 -0400
Message-ID: <44E1BF29.8010405@tls.msk.ru>
Date: Tue, 15 Aug 2006 16:33:45 +0400
From: Michael Tokarev <mjt@tls.msk.ru>
User-Agent: Mail/News 1.5 (X11/20060318)
MIME-Version: 1.0
To: Carsten Otto <carsten.otto@gmail.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Daily crashes, incorrect RAID behaviour
References: <13e988610608150436y6812f623p9919b2d5b1989427@mail.gmail.com>
In-Reply-To: <13e988610608150436y6812f623p9919b2d5b1989427@mail.gmail.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Carsten Otto wrote:
> Hello!
> 
> System specs below (iCH7R, software raid 5)
> 
> My problems continue, even with a new and good power supply.
> 1) The system loses a disk about every week, only a hard reboot solves that

We've seen this in alot of cases in the past.  The issue was in a single
batch of seagate 9gig drives (yes, old) - from time to time, one disk
just disappears from the system completely, only power-off-on cycle
forces it to reappear.  This happens without any pattern, ie, randomly -
sometimes a disk can disappear after several minutes after a power-on,
without any system load; and some times, it works just fine for several
months.

We tried to replace (RMA) the bad drives one by one, with the same
scenario all the time: they test the drive for a day, and call us back
saying everything's ok; we grab the drive, and return it back the next
day (because we *know* it's NOT Ok), and they send it for replacement.
The replaced drives (even refurbished ones) all works ok (we replaced
about 20 drives in total, all from the same batch).

I talked with seagate techs about this issue, but there was no conclusion
(he said it's "typical mishandling", like static elictricity etc, but
that does not match the behaviour at all).  And since the drives are very
old now (but quite some of them are still in production ;), and was already
quite old when the problem started happening (about 6 years ago).. it's
simpler to trash them, replacing with more modern drives.

That was only one batch of drives.  And the drives was excellent (for their
age anyway): no single disk failure in many years, not even single bad block
on about 50 drives!  If not counting those sporadic disappearing of course ;)
And Seagate guys says this is something they've never hear before, too.

That all to say: sometimes disk drives do strange things.  Rare, very rare,
but that happens... ;)

/mjt
