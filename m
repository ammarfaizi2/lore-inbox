Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161359AbWJKTaf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161359AbWJKTaf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 15:30:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161360AbWJKTae
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 15:30:34 -0400
Received: from mailer.gwdg.de ([134.76.10.26]:43232 "EHLO mailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1161358AbWJKTad (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 15:30:33 -0400
Date: Wed, 11 Oct 2006 21:28:46 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: "H. Peter Anvin" <hpa@zytor.com>
cc: Al Viro <viro@ftp.linux.org.uk>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] use %p for pointers
In-Reply-To: <452D4306.3040407@zytor.com>
Message-ID: <Pine.LNX.4.61.0610112128090.9822@yvahk01.tjqt.qr>
References: <E1GXPU5-0007Ss-HU@ZenIV.linux.org.uk>
 <Pine.LNX.4.61.0610111316120.26779@yvahk01.tjqt.qr> <20061011145441.GB29920@ftp.linux.org.uk>
 <452D3BB6.8040200@zytor.com> <Pine.LNX.4.61.0610112112450.9822@yvahk01.tjqt.qr>
 <452D4306.3040407@zytor.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> > > %p will do no such thing in the kernel.  As for the difference...
>> > > %x
>> > > might happen to work on some architectures (where sizeof(void
>> > > *)==sizeof(int)),
>> > > but it's not portable _and_ not right.  %p is proper C for that...
>> 
>> Ah I see your point, but then again, %lx could have been used. Unless
>> there is some arch where sizeof(long) != sizeof(void *).
>
> That really makes gcc bitch, *and* it's wrong for a whole bunch of reasons.

Ah my bad. Thanks for the slap reminder. :)


	-`J'
-- 
