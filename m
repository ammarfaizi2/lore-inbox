Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261413AbULNERY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261413AbULNERY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 23:17:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261408AbULNEQH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 23:16:07 -0500
Received: from smtp-out4.blueyonder.co.uk ([195.188.213.7]:6230 "EHLO
	smtp-out4.blueyonder.co.uk") by vger.kernel.org with ESMTP
	id S261405AbULNEPM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 23:15:12 -0500
Message-ID: <41BE68CA.4090506@blueyonder.co.uk>
Date: Tue, 14 Dec 2004 04:15:06 +0000
From: Sid Boyce <sboyce@blueyonder.co.uk>
Reply-To: sboyce@blueyonder.co.uk
Organization: blueyonder.co.uk
User-Agent: Mozilla Thunderbird 1.0RC1 (X11/20041201)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.10-rc3 vs clock
References: <41BE2616.2080709@blueyonder.co.uk> <200412132059.01101.gene.heskett@verizon.net>
In-Reply-To: <200412132059.01101.gene.heskett@verizon.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 14 Dec 2004 04:15:40.0531 (UTC) FILETIME=[925E4430:01C4E193]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gene Heskett wrote:
> On Monday 13 December 2004 18:30, Sid Boyce wrote:
> 
>>I'm seeing uptime 11:26pm  up 1 day 13:30 and my clock is around 190
>>secs fast, I don't know if this happened only at 2.6.10-rc3, but
>>that's when I noticed it on this XP3000+. On the x86_64 laptop also
>>with 2.6.10-rc3, it's bang on time in uptime 5 days 2:11.
>>Regards
>>Sid.
> 
> 
> I've been playng with the tickadj command, and am currently set
> at 9926, default is 10,000.  And I'm keeping pretty good time now.
> Running ntpdate in slew the clock mode, once per hour, I'm
> logging this now:
> Dec 13 12:35:03 coyote ntpdate[26529]: adjust time server
> 140.142.16.34 offset 0.043227 sec
> Dec 13 13:35:01 coyote ntpdate[27572]: adjust time server
> 18.145.0.30 offset 0.248119 sec
> Dec 13 14:35:05 coyote ntpdate[28624]: adjust time server
> 204.123.2.72 offset 0.156707 sec
> Dec 13 15:35:03 coyote ntpdate[29486]: adjust time server
> 198.30.92.2 offset 0.245309 sec
> Dec 13 16:35:04 coyote ntpdate[30400]: adjust time server
> 164.67.62.194 offset 0.105258 sec
> Dec 13 17:35:01 coyote ntpdate[31320]: adjust time server
> 130.207.244.240 offset 0.036849 sec
> Dec 13 18:35:01 coyote ntpdate[32229]: adjust time server
> 18.145.0.30 offset 0.254626 sec
> Dec 13 19:35:10 coyote ntpdate[741]: adjust time server
> 198.30.92.2 offset 0.276145 sec
> Dec 13 20:35:02 coyote ntpdate[1858]: adjust time server
> 128.252.19.1 offset 0.151181 sec
> 
> So while its not perfect, its adequate.
> 
> As to whats doing it, I have NDI.
> 
Thanks, I set it to 9942 and checking with ptktime and it's looking 
good, before it was drifting by 3 seconds by this time - with 9926 it 
was losing slightly, 2 secs in about 5 minutes. On the laptops and the 
Mandrake box that are rock solid it is set at 10,000, the P-II/333 
laptop is using the SuSE 9.2 kernel and the others are on 2.6.10-rc3.
Regards
Sid.
-- 
Sid Boyce .... Hamradio G3VBV and keen Flyer
=====LINUX ONLY USED HERE=====
