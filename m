Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264444AbUHNSbj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264444AbUHNSbj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Aug 2004 14:31:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264479AbUHNSbj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Aug 2004 14:31:39 -0400
Received: from YahooBB219197212132.bbtec.net ([219.197.212.132]:16000 "EHLO
	rai.sytes.net") by vger.kernel.org with ESMTP id S264444AbUHNSb3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Aug 2004 14:31:29 -0400
Message-ID: <411E5A88.5040402@yahoo.co.jp>
Date: Sun, 15 Aug 2004 03:31:36 +0900
From: Tetsuji Rai <badtrans666@yahoo.co.jp>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en, ja, zh-tw, zh-cn, zh-hk
MIME-Version: 1.0
CC: linux-kernel@vger.kernel.org
Subject: Re: Keyboard input ignored by 2.6.8
References: <411E40F2.6000000@yahoo.co.jp> <411E4D15.9080708@yahoo.co.jp>
In-Reply-To: <411E4D15.9080708@yahoo.co.jp>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I solved this problem by myself.   I had been using a USB mouse and a PS/2
keyboard.   After I switched my mouse to PS/2 mode and disabled usb mouse
support in BIOS, then 2.6.8 accepts my keyboard input.   It's good for me,
but it will affect people having only usb keyboards and mice...

Tetsuji Rai wrote:
> In addition, I had disabled the usb keyboard in bios.
> 
> Tetsuji Rai wrote:
> 
>>Today I compiled 2.6.8 on my Debian sarge with gcc-3.4(and tested with
>>gcc-3.3 also), and found 2.6.8 didn't accept my keyboard input.   My
>>keybaord is a usual PS/2 keyboard.  I don't know what's going on.  I cannot
>>even login.   Until today I have been using 2.6.7 without any problem.   I
>>attach my .config file as the attachment.
>>
>>Another (minor?) problem is when I compiled into usb stuff into the 2.6.8
>>kernel, it freezed on booting.  So I compiled usb stuff as modules and it
>>was solved.
>>
>>
>>TIA
>>
> 
> 


-- 
Tetsuji Rai (in Tokyo) aka AF-One (Athlete's Foot-One)
Born to be the luckiest guy in the world!   May the Force be with me!
http://www.geocities.com/tetsuji_rai
http://setiathome.ssl.berkeley.edu/fcgi-bin/fcgi?cmd=view_feedback&id=1855
