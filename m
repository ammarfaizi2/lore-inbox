Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750723AbVLTBLx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750723AbVLTBLx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Dec 2005 20:11:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750724AbVLTBLx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Dec 2005 20:11:53 -0500
Received: from mail18.syd.optusnet.com.au ([211.29.132.199]:60838 "EHLO
	mail18.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1750723AbVLTBLw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Dec 2005 20:11:52 -0500
From: Con Kolivas <kernel@kolivas.org>
To: gene.heskett@verizononline.net
Subject: Re: -rc6 vs desktop use, desktop 0
Date: Tue, 20 Dec 2005 12:12:07 +1100
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org
References: <200512191808.18784.gene.heskett@verizon.net> <200512191956.25352.gene.heskett@verizon.net>
In-Reply-To: <200512191956.25352.gene.heskett@verizon.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512201212.07839.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Dec 2005 11:56 am, Gene Heskett wrote:
> On Monday 19 December 2005 18:08, Gene Heskett wrote:
> >Greetings;
> >
> >I tried to rebuild rc6 without the size optimizations, but that
> >resulted in some sort of a timer problem being logged at about 1
> >second intervals to the vt's.
> >
> >I'm back in rc5 now, cause rc6 is best described as a dog for desktop
> >use, kmail freezes for 10 seconds at a time.  rc5 does do that nearly
> >as bad.
> >
> >Useing Con's scheduler as default in both cases.
>
> Humm, no comment from anyone so far.  Do you need more data? i686
> (athlon) cpu, gig of ram, what else do you need?
>
> I could attach the .config I suppose. I did look to see if an option
> had been added to use the desktop/server versions of Cons newer
> patches, but its not visible in a make xconfig.  Is this something
> thats going to be needed, or should I switch scheduelers?

Are you just using my cpu scheduler or dynticks from my patches as well? 
Dynticks still has quirks every so often but the cpu scheduler is unchanged 
for about 2 months now.

Cheers,
Con
