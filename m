Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267344AbUIEXiK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267344AbUIEXiK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Sep 2004 19:38:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267345AbUIEXiK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Sep 2004 19:38:10 -0400
Received: from anchor-post-33.mail.demon.net ([194.217.242.91]:12298 "EHLO
	anchor-post-33.mail.demon.net") by vger.kernel.org with ESMTP
	id S267344AbUIEXiG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Sep 2004 19:38:06 -0400
Message-ID: <413BA35C.8080705@superbug.demon.co.uk>
Date: Mon, 06 Sep 2004 00:38:04 +0100
From: James Courtier-Dutton <James@superbug.demon.co.uk>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040812)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alex Owen <owen@cus.org.uk>
CC: glen.turner@aarnet.edu.au, linux-kernel@vger.kernel.org
Subject: Re: Linux serial console patch
References: <20040905175037.O58184@cus.org.uk>
In-Reply-To: <20040905175037.O58184@cus.org.uk>
X-Enigmail-Version: 0.84.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alex Owen wrote:
> Glen Turner,
> 
> I have read your posts to lkml containing your serial console flow control
> patches firstly for 2.4.x and then for 2.6.x kernels.
> 
> Rationale:
>  "[PATCH] 0/3 Fix serial console flow control"
>     http://www.ussg.iu.edu/hypermail/linux/kernel/0210.1/1790.html
> 2.4 patches:
>  "[PATCH] 1/3 Fix serial console flow control, serial.c"
>     http://www.ussg.iu.edu/hypermail/linux/kernel/0210.1/1791.html
>  "[PATCH] 2/3 Fix serial console flow control, serialP.h"
>     http://www.ussg.iu.edu/hypermail/linux/kernel/0210.1/1792.html
>  "[PATCH] 3/3 Fix serial console flow control, serial-console.txt"
>     http://www.ussg.iu.edu/hypermail/linux/kernel/0210.1/1793.html
> 2.6 patch:
>  "[PATCH] Fix CTS/RTS flow control in serial console"
>     http://www.ussg.iu.edu/hypermail/linux/kernel/0310.2/1080.html
> 
> I have not been able to find any feedback on those patches in the lkml
> archives. Also I can find no evidence that the patch made it into the
> 2.6.8.1 kernel. This is a shame as I found your rationale very
> persuasive.
> 
> Do you maintain an up-to-date version of this patch?
> Did you get any feedback for this patch, positive or negative?
> Do you need people (i.e. me) to test this patch?
> 
> Thanks
> Alex Owen
> -

Does this fix junk being output from the serial console?
If one is using Pentium 4 HT, it seems that both CPU cores try to send 
characters to the serial port at the same time, resulting in lost 
characters as one CPU over writes the output from the other.

