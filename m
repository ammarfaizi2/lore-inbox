Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262251AbULRAJf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262251AbULRAJf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Dec 2004 19:09:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262241AbULRAHx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Dec 2004 19:07:53 -0500
Received: from smtp-out3.blueyonder.co.uk ([195.188.213.6]:37950 "EHLO
	smtp-out3.blueyonder.co.uk") by vger.kernel.org with ESMTP
	id S262244AbULRAGJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Dec 2004 19:06:09 -0500
Message-ID: <41C3746D.8090308@blueyonder.co.uk>
Date: Sat, 18 Dec 2004 00:06:05 +0000
From: Sid Boyce <sboyce@blueyonder.co.uk>
Reply-To: sboyce@blueyonder.co.uk
Organization: blueyonder.co.uk
User-Agent: Mozilla Thunderbird 1.0RC1 (X11/20041201)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.10-rc3 vs clock
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 18 Dec 2004 00:06:38.0436 (UTC) FILETIME=[71D68240:01C4E495]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill Davidsen wrote:
Gene Heskett wrote:

 >>    At -rc2 my clock kept fairly decent time, but -rc3 is running 
fast, about 30 seconds an hour fast.
 >>
 >>    I've been using ntpdate, is that now officially deprecated?

 > Running ntpd used to keep the clock dead on, now my 2.6 systems all 
drift one way or the other. I suspect that the system calls used by ntpd 
 > have changed somehow, but until I find the time to look harder I 
can't > say that except as conjecture.
 >
 > The sad thing is that most of the systems have quite good hardware 
clocks...

Gene Heskett suggested I play around with tickadj and I found that a 
value of 9962 on this SuSE 9.2/XP3000+ has kept it rock solid over the 
last 4 days. On the x86_64 laptop with XP3000+-Mobile, it's never been 
out, both of them running 2.6.10-rc3 and using ntpd to keep in step. On 
the other box with Mandrake 10.1/XP2800+ and 2.6.10-rc3, I had to set it 
to 9958. Something has definitely changed with 2.6.10-rc3.
Regards
Sid.
-- 
Sid Boyce .... Hamradio G3VBV and keen Flyer
=====LINUX ONLY USED HERE=====
