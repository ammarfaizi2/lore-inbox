Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317101AbSGHSzm>; Mon, 8 Jul 2002 14:55:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317107AbSGHSzl>; Mon, 8 Jul 2002 14:55:41 -0400
Received: from [195.63.194.11] ([195.63.194.11]:4877 "EHLO mail.stock-world.de")
	by vger.kernel.org with ESMTP id <S317101AbSGHSzk> convert rfc822-to-8bit;
	Mon, 8 Jul 2002 14:55:40 -0400
Message-ID: <3D29E0CB.9040402@evision-ventures.com>
Date: Mon, 08 Jul 2002 20:58:19 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0.0) Gecko/20020611
X-Accept-Language: pl, en-us
MIME-Version: 1.0
To: Andries.Brouwer@cwi.nl
CC: linux-kernel@vger.kernel.org
Subject: Re: IDE, util-linux
References: <UTC200207081502.g68F2I701471.aeb@smtp.cwi.nl>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

U¿ytkownik Andries.Brouwer@cwi.nl napisa³:
> Yesterday util-linux 2.11t was released.
> As always, comments are welcome.
> 
> Wanted to continue some usb-storage work on 2.5 and
> recklessly booted 2.5.25. It survived for several hours,
> then deadlocked. Two filesystems turned out to be corrupted.
> Wouldn't mind if the rock solid 2.4 handling of HPT366
> was carefully copied to 2.5, that today quickly causes
> corruption and quickly deadlocks or crashes.
> [Yes, these are independent bugs. The fact that the current
> IDE code writes to random disk sectors is much more annoying
> than the fact that it crashes and deadlocks. This random
> writing is observed only on disks on the HPT366 card.]

Well the point is that the 2.5.25 is well behind whats
going on. It still contains IDE 93, which *is* broken.
Please hunt for IDE 94 + 95 + 96 [without 97]. This should
help. Anyway. My plan is to provide a 98 soon which will
be cummulative against 2.5.25, just to geive people a chance
to work on it again. But as it stands - *plain* 2.5.25 is
indeed very dangerous in this regard.


