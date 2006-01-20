Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751058AbWATQcY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751058AbWATQcY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 11:32:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751060AbWATQcY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 11:32:24 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:33498 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1751058AbWATQcW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 11:32:22 -0500
Date: Fri, 20 Jan 2006 17:32:19 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Bill Davidsen <davidsen@tmr.com>
cc: Willy Tarreau <willy@w.ods.org>, Rumi Szabolcs <rumi_ml@rtfm.hu>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.4.x kernel uptime counter problem
In-Reply-To: <43D0FF40.9060305@tmr.com>
Message-ID: <Pine.LNX.4.61.0601201731130.10065@yvahk01.tjqt.qr>
References: <20060119110834.bb048266.rumi_ml@rtfm.hu>
 <7c3341450601190129r64a97880q22d576734214b6ac@mail.gmail.com>
 <20060119201857.GQ7142@w.ods.org> <200601192022.42087.nick@linicks.net>
 <Pine.LNX.4.61.0601201513360.22940@yvahk01.tjqt.qr> <43D0FF40.9060305@tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Or use some dedicated programs, IIRC there is a "uprecords" program
>> (http://podgorny.cz/moin/Uptimed). Does require no reboot and should work
>> right away.
>
> I never understood uptime anyway, the boot time, to the second, is available in
> /proc/stat (btime), and it isn't that hard to turn it into whatever format you
> find human readable. I have a perl script which presents uptime as fractional
> days, days, hours, min, sec, and/or boot time. Took me about two minutes to
> write.

uptime or uptimed/uprecords? (That's two different things.)
The "uptime" commands is the same as "w | head -n1" (which reads 
/proc/uptime) and therefore suffers from jiffies wrap.



Jan Engelhardt
-- 
