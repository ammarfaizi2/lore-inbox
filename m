Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277246AbRJQViT>; Wed, 17 Oct 2001 17:38:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277252AbRJQViM>; Wed, 17 Oct 2001 17:38:12 -0400
Received: from mailout00.sul.t-online.com ([194.25.134.16]:43757 "EHLO
	mailout00.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S277246AbRJQVh7>; Wed, 17 Oct 2001 17:37:59 -0400
Date: Wed, 17 Oct 2001 23:38:11 +0200 (CEST)
From: bartscgr@t-online.de (Guenter Bartsch)
X-X-Sender: <guenter@goofy.disney.gb>
Reply-To: <bartscgr@studbox.uni-stuttgart.de>
To: <linux-kernel@vger.kernel.org>
cc: xine-dev <xine-devel@lists.sourceforge.net>
Subject: Re: xine pauses with recent (not -ac) kernels
Message-ID: <Pine.LNX.4.33.0110172335160.3116-100000@goofy.disney.gb>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

after some experimentation it seems clear to me that the problem is (at
least not fully) raw-device related. Some plugins authenticate and unlock
the drive each time they're opened and some of the ioctl's used for that
seem to hang for a long time :-(

...ist there any hope that this is going to be fixed soon?

please cc any reply if you're reading this on the kernel mailing list as
I'm not subscribed to that list.

Cheers,

   Guenter

--
time is a funny concept

