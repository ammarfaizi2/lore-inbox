Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750824AbVKCIym@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750824AbVKCIym (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 03:54:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751091AbVKCIym
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 03:54:42 -0500
Received: from [85.8.13.51] ([85.8.13.51]:46485 "EHLO smtp.drzeus.cx")
	by vger.kernel.org with ESMTP id S1750824AbVKCIym (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 03:54:42 -0500
Message-ID: <4369D04C.70509@drzeus.cx>
Date: Thu, 03 Nov 2005 09:54:36 +0100
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Mail/News 1.4.1 (X11/20051008)
MIME-Version: 1.0
To: Vojtech Pavlik <vojtech@ucw.cz>, dtor_core@ameritech.net
CC: LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@suse.cz>
Subject: keyboard dies during failed suspend attempt
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I discovered a problem with my laptop keyboard when the machine failed 
to suspend. Pavel Machek pointed me in your direction for guidance. :)

The original issue (swsusp failing) is in this thread:

http://marc.theaimsgroup.com/?t=113093802700002&r=1&w=2

The side issue is that the keyboard goes completely dead when the 
suspend fails like this. Not even hardware buttons that control the 
intensity of the TFT backlight work.

The problem doesn't happen every time, but it seems to be often enough 
to do some decent testing.

The problem seems to have appeared after 2.6.14 was released. Since the 
  problem is intermittent I can't be 100% sure of this, but it's fairly 
likely since none of the tests before 2.6.14 failed.

Rgds
Pierre
