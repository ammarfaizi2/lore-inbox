Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262796AbUDDVHo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Apr 2004 17:07:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262797AbUDDVHo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Apr 2004 17:07:44 -0400
Received: from mailgate4.cinetic.de ([217.72.192.167]:45186 "EHLO
	mailgate4.cinetic.de") by vger.kernel.org with ESMTP
	id S262796AbUDDVHn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Apr 2004 17:07:43 -0400
Message-ID: <40707888.80006@web.de>
Date: Sun, 04 Apr 2004 23:05:12 +0200
From: Marcus Hartig <m.f.h@web.de>
Organization: Linux of Borgs
User-Agent: Mozilla Thunderbird 0.5+ (X11/20040323)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.5-aa1
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > This fixes a tiny race in the recent mprotect merging code, here's the
 > intradiff for review, plus it merges some nice lowlatency improvement
 > from Takashi.

Runs fine her with my GNOME 2.6 desktop. Fast like Speedy Gonzales.
Good work.

But now with the vanilla 2.6.5 and/or -aa1 my favourite game Enemy 
Territory quits with "signal 11". With 2.6.5-rc3 it runs stable for hours.

No change in the kernel config, all with preempt, no CONFIG_REGPARM for 
nVidia binary drivers is set, or other changes. But only when I want to 
access the net server game browser in ET to play online! Only then bumm!

With 2.6.5-rc3 all runs fine. Amusingly, hmmm?

Marcus
