Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263667AbTIBKmZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 06:42:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263696AbTIBKmY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 06:42:24 -0400
Received: from smtp805.mail.sc5.yahoo.com ([66.163.168.184]:64537 "HELO
	smtp805.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S263667AbTIBKlD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 06:41:03 -0400
Message-ID: <3F547494.6080205@sbcglobal.net>
Date: Tue, 02 Sep 2003 05:44:36 -0500
From: Wes Janzen <superchkn@sbcglobal.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i586; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
CC: Ian Kumlien <pomac@vapor.com>, Daniel Phillips <phillips@arcor.de>,
       linux-kernel@vger.kernel.org, Robert Love <rml@tech9.net>
Subject: Re: [SHED] Questions.
References: <1062324435.9959.56.camel@big.pomac.com> <200309011707.20135.phillips@arcor.de> <1062457396.9959.243.camel@big.pomac.com> <200309021023.24763.kernel@kolivas.org>
In-Reply-To: <200309021023.24763.kernel@kolivas.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote:

> ...
>
>The cpu scheduler simply isn't broken as the people on this mailing list seem 
>to think it is. While my tweaks _look_ large, they're really just tweaking 
>the way the numbers feed back into a basically unchanged design.
>
>...
>

For what it's worth, I haven't had any problems with Con's O19int.  I've 
been trying to repeat a case of priority inversion I experienced with 
O18.1...but it seems to be cured (and that was really my only problem 
with it).  I was already getting fewer skips in XMMS with 
2.6.0-test3-mm2 than I did with 2.4.18 and the same sort of workload.  I 
can't really test xmms now that the ACPI changes have obliterated my 
chances of freeing IRQ 5 for my sb16 -- but from the improvements I feel 
in the last few patches from Con, I imagine that it wouldn't skip 
anymore.  (On a side note, I really miss xmms where random means quite 
random, unlike my CD changer which is repeat the same songs in a four 
hour block.)  I certainly am not running any sort of high-end machine 
with a K6-2 400 ;-)  The mouse might lag slightly for a few seconds when 
starting up a build, but as soon as the scheduler adjusts, I can't tell 
whether I have four builds running at the same time or just one.  In 
2.4.18, it has a slow feeling that let's you know the system is loaded 
-- and it never goes away (well, until the compiling's done).

-Wes-

