Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264084AbUDBPpm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Apr 2004 10:45:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264091AbUDBPpl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Apr 2004 10:45:41 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.106]:62975 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264084AbUDBPpj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Apr 2004 10:45:39 -0500
In-Reply-To: <20040331045028.0B4581CE504@ws3-6.us4.outblaze.com>
Subject: Re: [LTP] file system race condition testing
To: "dan carpenter" <error27@email.com>
Cc: linux-kernel@vger.kernel.org, ltp-list@lists.sourceforge.net
X-Mailer: Lotus Notes Release 6.0.2CF1 June 9, 2003
Message-ID: <OF9AC892C7.16E0DF08-ON85256E6A.0056638F-86256E6A.00569E93@us.ibm.com>
From: Robert Williamson <robbiew@us.ibm.com>
Date: Fri, 2 Apr 2004 09:44:44 -0600
X-MIMETrack: Serialize by Router on D01ML076/01/M/IBM(Release 6.0.2CF2 HFB2|March 10, 2004) at
 04/02/2004 10:44:47
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org





Thanks for the test Dan!  I'm going to place it with our filesystem tests,
and it should be in this month's release (sometime next week).

-Robbie

Robert V. Williamson <robbiew@us.ibm.com>
Linux Test Project
IBM Linux Technology Center
Web: http://www.linuxtestproject.org
IRC: #ltp on freenode.irc.net
====================
"Only two things are infinite, the universe and human stupidity, and I'm
not sure about the former." -Albert Einstein

ltp-list-admin@lists.sourceforge.net wrote on 03/30/2004 10:50:28 PM:

> Hi,
>
> I wrote this script a while back.  It creates 20 files, 0 through 19,
> and then shuffles them around, deletes and recreates them as fast as
> possible.
>
> It's a good way to test for race conditions.  I always run with
> preempt turned on so that makes my system more sensitive to race
> conditions.  Neither JFS or Reiserfs survived a whole night of testing
> on my system.  It's a pretty grueling test...
>
> http://67.113.20.209/racer.tar.gz
>
> regards,
> dan
>
>
> --
> ___________________________________________________________
> Sign-up for Ads Free at Mail.com
> http://promo.mail.com/adsfreejump.htm
>
>
>
> -------------------------------------------------------
> This SF.Net email is sponsored by: IBM Linux Tutorials
> Free Linux tutorial presented by Daniel Robbins, President and CEO of
> GenToo technologies. Learn everything from fundamentals to system
> administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list

