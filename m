Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261860AbVCKBP5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261860AbVCKBP5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 20:15:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262244AbVCKBP4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 20:15:56 -0500
Received: from ns1.g-housing.de ([62.75.136.201]:14752 "EHLO mail.g-house.de")
	by vger.kernel.org with ESMTP id S261860AbVCKBOS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 20:14:18 -0500
Message-ID: <4230F0E6.5080708@g-house.de>
Date: Fri, 11 Mar 2005 02:14:14 +0100
From: Christian Kujau <evil@g-house.de>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050212)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Andrew Morton <akpm@osdl.org>
Subject: Re: oom with 2.6.11
References: <422DC2F1.7020802@g-house.de>	<3f250c710503090518526d8b90@mail.gmail.com>	<3f250c7105030905415cab5192@mail.gmail.com>	<422F016A.2090107@g-house.de>	<423063DB.40905@g-house.de> <20050310163956.0a5ff1d7.akpm@osdl.org>
In-Reply-To: <20050310163956.0a5ff1d7.akpm@osdl.org>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Christian Kujau <evil@g-house.de> wrote:
> 
>>i was going to compile 2.6.11-rc5-bk4, to sort out the "bad" kernel.
>>compiling went fine. ok, finished some email, ok, suddenly my swap was
>>used up again, and no memory left - uh oh! OOM again, with 2.6.11-rc5-bk2!
> 
> 
> Well if you ran out of swap then yes, the oom-killer will visit you.
> 
> Why did you run out of swapspace?

hm, if i only knew. i don't know how long it took the other night to go
from "normal" to "OOM". but today, with 2.6.11-rc5-bk2 (well, yesterday
actually) i was working normally, and all of a sudden swap goes from 170MB
used swap (normal) to OOM. i think it took a minute or so, but i just
can't tell which application went nuts. today the first process that got
killed was "ssh-agent", the other day it was mysqld. but even after this,
it should've released some memory, right? but the oom-killer goes on and
on and kills the next task.

i'll monitor memory usage tonight and see what it gives. these "pppd"
messages are suspicious though.

thank you,
Christian.
-- 
BOFH excuse #135:

You put the disk in upside down.
