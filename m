Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262175AbULCMG7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262175AbULCMG7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Dec 2004 07:06:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262177AbULCMG7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Dec 2004 07:06:59 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:39889 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S262175AbULCMG5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Dec 2004 07:06:57 -0500
Date: Fri, 3 Dec 2004 13:06:51 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Rahul Karnik <deathdruid@gmail.com>
cc: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: cdrecord dev=ATA cannont scanbus as non-root [u]
In-Reply-To: <5b64f7f041203035133c53d10@mail.gmail.com>
Message-ID: <Pine.LNX.4.53.0412031306080.1932@yvahk01.tjqt.qr>
References: <1101763996l.13519l.0l@werewolf.able.es>  <20041130071638.GC10450@suse.de>
  <1101935773.11949.86.camel@nosferatu.lan>  <200412021723.48883.astralstorm@gorzow.mm.pl>
  <Pine.LNX.4.53.0412030834330.26749@yvahk01.tjqt.qr> <5b64f7f041203035133c53d10@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> > Ok, so I am a bit confused here.  We basically have 3 ways to use
>> >> cdrecord on linux-2.6 without ide-scsi:
>> >>
>> >> 1) cdrecord dev=/dev/hdx
>> >> 2) cdrecord dev=ATA
>> >> 3) cdrecord dev=ATAPI
>> >>
>> >> Now, if I run all three and grep for '^Warning', I get:
>>
>> Worse, yet, there is no DMA for any of these three :-(
>
>Not true in 2.6. 1 definitely uses DMA now (disregard the damn
>warning). And why would anyone use 2 or 3?

Right, forgot to add. Read as "no DMA for any that does not give a cdrecord
warning".



Jan Engelhardt
-- 
ENOSPC
