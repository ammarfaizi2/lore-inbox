Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750700AbWATPRo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750700AbWATPRo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 10:17:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750711AbWATPRo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 10:17:44 -0500
Received: from prgy-npn2.prodigy.com ([207.115.54.38]:19042 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP
	id S1750700AbWATPRo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 10:17:44 -0500
Message-ID: <43D0FF40.9060305@tmr.com>
Date: Fri, 20 Jan 2006 10:18:24 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050920
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
CC: Willy Tarreau <willy@w.ods.org>, Rumi Szabolcs <rumi_ml@rtfm.hu>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.4.x kernel uptime counter problem
References: <20060119110834.bb048266.rumi_ml@rtfm.hu> <7c3341450601190129r64a97880q22d576734214b6ac@mail.gmail.com> <20060119201857.GQ7142@w.ods.org> <200601192022.42087.nick@linicks.net> <Pine.LNX.4.61.0601201513360.22940@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0601201513360.22940@yvahk01.tjqt.qr>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt wrote:
>>>>You can use:
>>>>last -xf /var/run/utmp runlevel
>>>>
>>>>to get true uptime in this instance.
> 
> 
> Or use some dedicated programs, IIRC there is a "uprecords" program
> (http://podgorny.cz/moin/Uptimed). Does require no reboot and should 
> work right away.

I never understood uptime anyway, the boot time, to the second, is 
available in /proc/stat (btime), and it isn't that hard to turn it into 
whatever format you find human readable. I have a perl script which 
presents uptime as fractional days, days, hours, min, sec, and/or boot 
time. Took me about two minutes to write.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
