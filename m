Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261200AbTIVWXz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 18:23:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261287AbTIVWXz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 18:23:55 -0400
Received: from mail.g-housing.de ([62.75.136.201]:46267 "EHLO mail.g-house.de")
	by vger.kernel.org with ESMTP id S261200AbTIVWXx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 18:23:53 -0400
Message-ID: <3F6F9289.3050706@g-house.de>
Date: Tue, 23 Sep 2003 02:23:37 +0200
From: Christian Kujau <evil@g-house.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5b) Gecko/20030909
X-Accept-Language: de, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: lockups with 2.4.2x
References: <3F6D134E.2080505@g-house.de>
In-Reply-To: <3F6D134E.2080505@g-house.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi again,


i seem to have the source to my problem here. a little application named 
"dnetc" (RC5-72 number cruncher, see http://www.distributed.net) causes 
the lockups when running under 2.4.22. no joke, i too don't want to 
believe this, but it's quite reproducable.

ok, the thing is: yes, i can live without this st00pid number-cruncher, 
so my system won't crash. otoh, i wonder why this little userspace 
application crashes a whole system so badly, that it's not even able to 
give an Oops. i will try to "strace ./dnetc" or execute it in the gdb, 
but i'm pretty sure, it will crash anyway, and the system won't have 
time to show errors or even write them to the disk.

btw, the "dnetc" is some kind of "open source but please don't look into 
it" thing, and even if we manage to compile it, the produced output is 
invalid.

oh, and i still did not try to remove memory and booting with no 
"highmem" or a "not preemtible kernel" and such. will do so, if that helps.

Thanks for reading,
Christian.

-- 
BOFH excuse #104:

backup tape overwritten with copy of system manager's favourite CD

