Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262675AbVAVHYk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262675AbVAVHYk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jan 2005 02:24:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262676AbVAVHYk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jan 2005 02:24:40 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:55545 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S262675AbVAVHYh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jan 2005 02:24:37 -0500
Message-ID: <41F1FFAA.4090707@mvista.com>
Date: Fri, 21 Jan 2005 23:24:26 -0800
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040308
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
CC: Tony Lindgren <tony@atomide.com>, Pavel Machek <pavel@ucw.cz>,
       john stultz <johnstul@us.ibm.com>, Andrea Arcangeli <andrea@suse.de>,
       Con Kolivas <kernel@kolivas.org>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dynamic tick patch
References: <20050119000556.GB14749@atomide.com> <Pine.LNX.4.61.0501192100060.3010@montezuma.fsmlabs.com> <20050121174831.GE14554@atomide.com> <Pine.LNX.4.61.0501211123260.18199@montezuma.fsmlabs.com> <41F16551.6090706@mvista.com> <Pine.LNX.4.61.0501211429270.18199@montezuma.fsmlabs.com>
In-Reply-To: <Pine.LNX.4.61.0501211429270.18199@montezuma.fsmlabs.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zwane Mwaikambo wrote:
> Hello George,
> 
> On Fri, 21 Jan 2005, George Anzinger wrote:
> 
> 
>>The VST patch on sourceforge
>>(http://sourceforge.net/projects/high-res-timers/) uses the local apic timer
>>to do the wake up.  This is the same timer that is used for the High Res work.
> 
> 
> I've been meaning to look into it, although it's quite a bit of work going 
> through all the extra code from the highres timer patch.

Well, really all it uses is the HR timer.  The rest of HRT is not really used 
for VST.  (Unless, of course, you are refering to the work over of the tsc timer 
tick code.)

-g
> 
> Thanks,
> 	Zwane
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/

