Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312215AbSCRGpX>; Mon, 18 Mar 2002 01:45:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312217AbSCRGpG>; Mon, 18 Mar 2002 01:45:06 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:13341 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S312215AbSCRGoy>; Mon, 18 Mar 2002 01:44:54 -0500
Date: Mon, 18 Mar 2002 01:44:50 -0500
From: Pete Zaitcev <zaitcev@redhat.com>
Message-Id: <200203180644.g2I6ioq03003@devserv.devel.redhat.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.5: Yamaha YMF744B
In-Reply-To: <mailman.1016430540.29118.linux-kernel2news@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> My Yamaha 744B Sound is not working with Linux 2.5.7-pre2 and ALSA Sound 
> Support.
>[...]
> am also aware that a there was some discussion about undocumented setup 
> required for the 744B chip specifically.  I was wondering whether this 
> issue had been resolved.
>[...]
> PS - Everything is fine with the OSS drivers in both 2.5 and 2.4.

ALSA and OSS share the code for ymfpci, it is basically the same,
including the early 744 workaround. Must be a typo in a setup somewhere.

-- Pete
