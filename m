Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274809AbRIUUK3>; Fri, 21 Sep 2001 16:10:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274810AbRIUUKT>; Fri, 21 Sep 2001 16:10:19 -0400
Received: from tmhoyle.gotadsl.co.uk ([195.149.46.162]:50693 "EHLO
	mail.cvsnt.org") by vger.kernel.org with ESMTP id <S274809AbRIUUKH>;
	Fri, 21 Sep 2001 16:10:07 -0400
From: "Tony Hoyle" <tmh@nothing-on.tv>
Subject: Reiserfs does not work from fstab in 2.4.9-ac12
Date: Fri, 21 Sep 2001 21:10:51 +0100
Organization: Magenta netLogic
Message-ID: <9og6rk$vd$1@sisko.my.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: sisko.my.home 1001103028 1005 192.168.100.2 (21 Sep 2001 20:10:28 GMT)
X-Complaints-To: abuse@cvsnt.org
User-Agent: Pan/0.10.0.90 (Unix)
X-Comment-To: ALL
X-No-Productlinks: Yes
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just got caught by this on a box which had a reiserfs /usr partition...

# mount /disk2
reiserfs: kgetopt: there is not option
<lots of mount failure stuff>

The fstab that generated this (which has worked for every other version,
so I believe it to be correct):
/dev/hdb1      /disk2          reiserfs        defaults        0       0

However
# mount -t reiserfs /dev/hdb1 /disk2

..works correctly.

Tony

-- 
Microsoft - two out of three dead people who expressed a preference
said their coffins preferred it.

tmh@nothing-on.tv	http://www.nothing-on.tv
