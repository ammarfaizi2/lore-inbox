Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266509AbUG0TXy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266509AbUG0TXy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 15:23:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266511AbUG0TXy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 15:23:54 -0400
Received: from smtp811.mail.sc5.yahoo.com ([66.163.170.81]:27754 "HELO
	smtp811.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S266509AbUG0TXu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 15:23:50 -0400
From: tabris <tabris@tabris.net>
To: Jens Axboe <axboe@suse.de>
Subject: Re: [Repost] IDE error 2.6.7-rc3-mm2 and 2.6.8-rc1-mm1
Date: Tue, 27 Jul 2004 14:07:10 -0400
User-Agent: KMail/1.6.1
Cc: linux-kernel@vger.kernel.org
References: <200407220659.22948.tabris@tabriel.tabris.net> <20040722153933.GJ3987@suse.de>
In-Reply-To: <20040722153933.GJ3987@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200407271407.10631.tabris@tabris.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 22 July 2004 11:39 am, Jens Axboe wrote:
> On Thu, Jul 22 2004, Tabris wrote:
> > -----BEGIN PGP SIGNED MESSAGE-----
> > Hash: SHA1
<snip log>
> > 	This error did not occur in 2.6.6-rc3-mm2. Turning off ACPI made
> > no difference, not that I expected one.
> >
> > 	It appears to be harmless but it's polluting my syslog.
> >
> > Appears related to
> > http://marc.theaimsgroup.com/?l=linux-kernel&m=108946389700930
> >
> > 	None of my harddrives are over 60GiB (and hda is an 8GiB), so
> > there's no reason i should be getting LBA48 Flush Cache.
> >
> > 	What should I do, what do you need from me to get to the bottom of
> > this?
>
> Does this work?
	No, however it does seem to start it going in my syslog a bit earlier, 
but that may be meaningless (normally I found it waited until after 
qmail would start).

	Also, my i2c/sensors have stopped working (tho I doubt it has anything 
to do with your patch, it _does_ lineup with my applying your patch and 
rebooting...)

--
tabris
