Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262060AbULCHfl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262060AbULCHfl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Dec 2004 02:35:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262073AbULCHfl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Dec 2004 02:35:41 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:36794 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S262060AbULCHfh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Dec 2004 02:35:37 -0500
Date: Fri, 3 Dec 2004 08:35:32 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
cc: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: cdrecord dev=ATA cannont scanbus as non-root [u]
In-Reply-To: <200412021723.48883.astralstorm@gorzow.mm.pl>
Message-ID: <Pine.LNX.4.53.0412030834330.26749@yvahk01.tjqt.qr>
References: <1101763996l.13519l.0l@werewolf.able.es> <20041130071638.GC10450@suse.de>
 <1101935773.11949.86.camel@nosferatu.lan> <200412021723.48883.astralstorm@gorzow.mm.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Ok, so I am a bit confused here.  We basically have 3 ways to use
>> cdrecord on linux-2.6 without ide-scsi:
>>
>> 1) cdrecord dev=/dev/hdx
>> 2) cdrecord dev=ATA
>> 3) cdrecord dev=ATAPI
>>
>> Now, if I run all three and grep for '^Warning', I get:

Worse, yet, there is no DMA for any of these three :-(


Jan Engelhardt
-- 
ENOSPC
