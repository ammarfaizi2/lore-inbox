Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262201AbSK0KwQ>; Wed, 27 Nov 2002 05:52:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262208AbSK0KwQ>; Wed, 27 Nov 2002 05:52:16 -0500
Received: from mailout04.sul.t-online.com ([194.25.134.18]:668 "EHLO
	mailout04.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S262201AbSK0KwP> convert rfc822-to-8bit; Wed, 27 Nov 2002 05:52:15 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
To: linux-kernel@vger.kernel.org
Subject: Re: FS-corrupting IDE bug still in 2.4.20-rc3
Date: Wed, 27 Nov 2002 11:59:23 +0100
User-Agent: KMail/1.4.3
Organization: WOLK - Working Overloaded Linux Kernel
Cc: nconway_kernel@yahoo.co.uk
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200211271158.13771.m.c.p@wolk-project.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,

> I've been off-list and not paying much attention since Andre
> acknowledged it was a bug (and didn't like my patch).
I can imagine why ...

> Let me be very clear: this bug has corrupted filesystems on three
> machines of mine.  All of these had PIIX chipsets.  I have also
> reproduced it on a VIA chipset, but since that machine was production I
> didn't try very hard to corrupt the fs.
You may try that patch with a VIA boxen and I am quite sure you may experience 
a bug that none of your harddisks may be recognized and result in a 
panic();

> The patch is not a real fix, merely a workaround.  But since 6 months
> have already elapsed, can I request that the patch be applied now, and
> when Andre creates a proper fix we can use that.
I had the same Fix in WOLK some time ago and many users with VIA chipset 
complained that with the fix their mashine does not recognize any harddisks 
and after trying to recognize they had a panic();

Maybe it's working for you with some VIA chipsets but I removed that fix and 
after removal all users with VIA were happy. I've never heard of a FS 
corruption of them.

ciao, Marc
