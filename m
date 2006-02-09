Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750750AbWBIUGw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750750AbWBIUGw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 15:06:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750758AbWBIUGw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 15:06:52 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:48563 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1750750AbWBIUGv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 15:06:51 -0500
Subject: Re: 2.6 vs 2.4, ssh terminal slowdown
From: Lee Revell <rlrevell@joe-job.com>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Con Kolivas <kernel@kolivas.org>, gcoady@gmail.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0602091806100.30108@yvahk01.tjqt.qr>
References: <j4kiu1de3tnck2bs7609ckmt89pfoumlbe@4ax.com>
	 <200602081335.18256.kernel@kolivas.org>
	 <Pine.LNX.4.61.0602091806100.30108@yvahk01.tjqt.qr>
Content-Type: text/plain
Date: Thu, 09 Feb 2006 15:06:45 -0500
Message-Id: <1139515605.30058.94.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.90 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-02-09 at 18:06 +0100, Jan Engelhardt wrote:
> >> grant@deltree:~$ time grep -v 192\.168\. /var/log/apache/access_log| cut
> >> -c-95 ...
> >
> >What happens if you add "| cat" on the end of your command?
> >
> Do you think it's the new pipe buffering thing? (Introduced 2.6.10-.12, 
> don't remember exactly)

If it's the same problem I've been seeing it goes back much farther than
2.6.10.

Lately I suspect the scheduler.

Lee

