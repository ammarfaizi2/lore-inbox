Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261309AbTKODC0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Nov 2003 22:02:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261311AbTKODC0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Nov 2003 22:02:26 -0500
Received: from mail-03.iinet.net.au ([203.59.3.35]:49330 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S261309AbTKODCY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Nov 2003 22:02:24 -0500
Message-ID: <3FB5973B.7040801@cyberone.com.au>
Date: Sat, 15 Nov 2003 14:02:19 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: Daniel Egger <degger@fhm.edu>
CC: Larry McVoy <lm@bitmover.com>,
       Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: kernel.bkbits.net off the air
References: <fa.eto0cvm.1v20528@ifi.uio.no>	 <200311112021.34631.andrew@walrond.org>	 <20031111235215.GA22314@work.bitmover.com>	 <200311131010.27315.andrew@walrond.org>	 <20031113162712.GA2462@work.bitmover.com>	 <1068766365.15965.228.camel@sonja>  <3FB4A6B7.5040306@cyberone.com.au> <1068809923.15965.240.camel@sonja>
In-Reply-To: <1068809923.15965.240.camel@sonja>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Daniel Egger wrote:

>Am Fre, den 14.11.2003 schrieb Nick Piggin um 10:56:
>
>
>>Actually, at http://www.kernel.org/ there is a link to daily snapshots.
>>There are also changesets generated every couple of hours at the "C" link
>>at the right of the page.
>>
>
>>Even if Linus doesn't release as often (doesn't he? I don't know), this
>>is surely much better than pre BK. Maybe I didn't understand you right?
>>
>
>Seems so. I assume you missed the "bandwidth constraint" part. Fetching
>a whole snapshot every day is not even close to workable. The snapshots
>in patch form are nice however patching forth and back is not really an
>option. If svn doesn't get back up I'd be tempted to use rsync and use
>vendor branches in my own SVN repository but this also seems far from
>optimal to me. rsync alone doesn't cut it because there's no version
>management and I've lost quite a few patches due to an not thoroughly
>considered rsync use.
>

There are compressed incremental patches of the snapshots available:
http://www.kernel.org/pub/linux/kernel/v2.6/snapshots/incr/
They average maybe 150KB per day.

Nick


