Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277112AbRJ0UtT>; Sat, 27 Oct 2001 16:49:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277097AbRJ0UtK>; Sat, 27 Oct 2001 16:49:10 -0400
Received: from moutvdom00.kundenserver.de ([195.20.224.149]:34673 "EHLO
	moutvdom00.kundenserver.de") by vger.kernel.org with ESMTP
	id <S277123AbRJ0Usx>; Sat, 27 Oct 2001 16:48:53 -0400
Date: Sat, 27 Oct 2001 22:50:08 +0200
From: Hans-Joachim Baader <hjb@pro-linux.de>
To: linux-kernel@vger.kernel.org
Subject: 2.4.14-3 via-rhine lockup
Message-ID: <20011027225007.A718@mandel.hjb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.13-current-20010108i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

on heavy load the via-rhine driver locks up. Even reloading the module
doesn't help, only reboot cures the problem.

I've set the debug variable in via-rhine.c to 7 and loaded the module
without options. In the kernel log I see:

via_rhine_rx() status is 00409700.

It still does interrupts and queues packets to send, but it either doesn't
send them or doesn't receive anything.

Who can help?

Thanks,
hjb
-- 
Pro-Linux - Germany's largest volunteer Linux support site
http://www.pro-linux.de/
