Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161394AbWASUM2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161394AbWASUM2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 15:12:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161385AbWASUM1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 15:12:27 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:32400 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1161388AbWASUMZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 15:12:25 -0500
Date: Thu, 19 Jan 2006 21:12:02 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Neil Brown <neilb@suse.de>
cc: "Lincoln Dale (ltd)" <ltd@cisco.com>, Michael Tokarev <mjt@tls.msk.ru>,
       linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
       "Steinar H. Gunderson" <sgunderson@bigfoot.com>
Subject: RE: [PATCH 000 of 5] md: Introduction
In-Reply-To: <17358.52476.290687.858954@cse.unsw.edu.au>
Message-ID: <Pine.LNX.4.61.0601192104560.26558@yvahk01.tjqt.qr>
References: <26A66BC731DAB741837AF6B2E29C1017D47EA0@xmb-hkg-413.apac.cisco.com>
 <Pine.LNX.4.61.0601181427090.19392@yvahk01.tjqt.qr> <17358.52476.290687.858954@cse.unsw.edu.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> >personally, I think this this useful functionality, but my personal
>> >preference is that this would be in DM/LVM2 rather than MD.  but given
>> >Neil is the MD author/maintainer, I can see why he'd prefer to do it in
>> >MD. :)
>> 
>> Why don't MD and DM merge some bits?
>
>Which bits?
>Why?
>
>My current opinion is that you should:
>
> Use md for raid1, raid5, raid6 - anything with redundancy.
> Use dm for multipath, crypto, linear, LVM, snapshot

There are pairs of files that look like they would do the same thing:

  raid1.c  <-> dm-raid1.c
  linear.c <-> dm-linear.c



Jan Engelhardt
-- 
