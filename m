Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268295AbUIHPot@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268295AbUIHPot (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 11:44:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268304AbUIHPot
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 11:44:49 -0400
Received: from unthought.net ([212.97.129.88]:33731 "EHLO unthought.net")
	by vger.kernel.org with ESMTP id S268295AbUIHPoh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 11:44:37 -0400
Date: Wed, 8 Sep 2004 17:44:34 +0200
From: Jakob Oestergaard <jakob@unthought.net>
To: Anando Bhattacharya <a3217055@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Major XFS problems...
Message-ID: <20040908154434.GE390@unthought.net>
Mail-Followup-To: Jakob Oestergaard <jakob@unthought.net>,
	Anando Bhattacharya <a3217055@gmail.com>,
	linux-kernel@vger.kernel.org
References: <20040908123524.GZ390@unthought.net> <322909db040908080456c9f291@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <322909db040908080456c9f291@mail.gmail.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 08, 2004 at 10:04:16AM -0500, Anando Bhattacharya wrote:
> Jakob, 
> 
> I am a XFS freak, I have a ton of servers with RAID  <hardware> and
> also run XFS over finely tuned NFS. Never had a problem. Only once
> when there was a power faliure, the journal took 20 mins to read to
> come back up. But otherwise XFS is pretty damn stable.
> My xfs box just runs linux 2.4.18-xfs and runs nfs over it on an
> Single Athlon 1800 or something like that has a 1GB of  RAM and has a
> 3Ware Raid card it shares to  about 200 workstations.

This, along with other information from XFS bugzilla and the xfs list
etc. etc. seems to suggest that there is a common trend:

SMP systems on 2.6 have a problem with XFS+NFS.

UP systems on 2.4 and possibly 2.6 does not have this problem.

We'll be testing with a 2.6.8.1 UP kernel, next time the big server
reboots (it's been up for the better part of a day now so it shouldn't
take long ;)

-- 

 / jakob

