Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750936AbWHKJPR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750936AbWHKJPR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Aug 2006 05:15:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750959AbWHKJPR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Aug 2006 05:15:17 -0400
Received: from mailer.gwdg.de ([134.76.10.26]:10151 "EHLO mailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1750932AbWHKJPP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Aug 2006 05:15:15 -0400
Date: Fri, 11 Aug 2006 11:07:44 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Bernd Petrovitsch <bernd@firmix.at>
cc: Jeff Mahoney <jeffm@suse.com>, Alexey Dobriyan <adobriyan@gmail.com>,
       Andrew Morton <akpm@osdl.org>, cmm@us.ibm.com,
       linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net,
       linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/9] sector_t format string
In-Reply-To: <1155285107.12126.0.camel@tara.firmix.at>
Message-ID: <Pine.LNX.4.61.0608111104100.30836@yvahk01.tjqt.qr>
References: <1155172843.3161.81.camel@localhost.localdomain> 
 <20060809234019.c8a730e3.akpm@osdl.org>  <20060810191747.GL20581@ca-server1.us.oracle.com>
  <20060810194440.GA6845@martell.zuzino.mipt.ru> <44DB945F.5080102@suse.com>
  <Pine.LNX.4.61.0608110757090.21588@yvahk01.tjqt.qr> <1155285107.12126.0.camel@tara.firmix.at>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1283855629-1242316001-1155287264=:30836"
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1283855629-1242316001-1155287264=:30836
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

>> >> Will
>> >> 
>> >> 	printk("%S", sector_t);
>> >> 
>> >> kill at least one kitten?
>> >
>> >I like the general idea. I think that having to cast every time you want
>> >to print a sector number is pretty gross. I had something more like %Su
>> >in mind, though.
>> 
>> What will happen if you run out of %[a-z] ?
>
>My keyboard can produce a lot more characters (even if I ignore the
>non-ASCII ones).

Oh yes I know we could use %ö %Д and %私 but that will possibly not amuse 
others outside your locale.
(Note, it should have been %[A-Za-z])



Jan Engelhardt
-- 
--1283855629-1242316001-1155287264=:30836--
