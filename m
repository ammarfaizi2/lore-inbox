Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932083AbVK1M7y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932083AbVK1M7y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Nov 2005 07:59:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932084AbVK1M7y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Nov 2005 07:59:54 -0500
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:32492 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932083AbVK1M7y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Nov 2005 07:59:54 -0500
Subject: Re: [RT] read_tsc: ACK! TSC went backward! Unsynced TSCs?
From: Steven Rostedt <rostedt@goodmis.org>
To: Jonas Oreland <jonas@mysql.com>
Cc: LKML <linux-kernel@vger.kernel.org>, john stultz <johnstul@us.ibm.com>,
       Ingo Molnar <mingo@elte.hu>
In-Reply-To: <438AF860.7050905@mysql.com>
References: <1133179554.11491.3.camel@localhost.localdomain>
	 <438AF860.7050905@mysql.com>
Content-Type: text/plain
Date: Mon, 28 Nov 2005 07:59:40 -0500
Message-Id: <1133182780.5625.4.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-11-28 at 13:30 +0100, Jonas Oreland wrote: 
> Steven Rostedt wrote:
> > Hi Ingo,
> > 
> > With -rt20 on the AMD64 x2, I'm getting a crap load of these:
> > 
> > read_tsc: ACK! TSC went backward! Unsynced TSCs?
> > 
> > So bad that the system wont even boot (at least I won't wait long enough
> > to let it finish).
> > 
> > config at: http://www.kihontech.com/tests/rt/config
> 
> Check this: http://bugzilla.kernel.org/show_bug.cgi?id=5105
> 
> Booting with idle=poll, fixes that.
> 
> Hope it help

I forgot to mention that I tried that too.  But thank you for sending
this, because, just to make sure, I tried it again, and now it booted.
I think I might have had a typo when adding idle=poll the first time.  I
think of this as a temporary solution, and I won't be adding that to
grub anytime soon.  Manually typing it in at boot time will keep me
remembering that it is there.  As long as I make sure that I type it
right ;-)

OK, this means that I don't want to stay in the -RT kernel too long
(electric prices are up you know).

-- Steve


