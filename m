Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261309AbULNB7I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261309AbULNB7I (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 20:59:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261366AbULNB7I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 20:59:08 -0500
Received: from out008pub.verizon.net ([206.46.170.108]:26758 "EHLO
	out008.verizon.net") by vger.kernel.org with ESMTP id S261309AbULNB7C
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 20:59:02 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org, sboyce@blueyonder.co.uk
Subject: Re: 2.6.10-rc3 vs clock
Date: Mon, 13 Dec 2004 20:59:00 -0500
User-Agent: KMail/1.7
References: <41BE2616.2080709@blueyonder.co.uk>
In-Reply-To: <41BE2616.2080709@blueyonder.co.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200412132059.01101.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out008.verizon.net from [151.205.42.94] at Mon, 13 Dec 2004 19:59:01 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 13 December 2004 18:30, Sid Boyce wrote:
>I'm seeing uptime 11:26pm  up 1 day 13:30 and my clock is around 190
>secs fast, I don't know if this happened only at 2.6.10-rc3, but
> that's when I noticed it on this XP3000+. On the x86_64 laptop also
> with 2.6.10-rc3, it's bang on time in uptime 5 days 2:11.
>Regards
>Sid.

I've been playng with the tickadj command, and am currently set
at 9926, default is 10,000.  And I'm keeping pretty good time now.
Running ntpdate in slew the clock mode, once per hour, I'm
logging this now:
Dec 13 12:35:03 coyote ntpdate[26529]: adjust time server
140.142.16.34 offset 0.043227 sec
Dec 13 13:35:01 coyote ntpdate[27572]: adjust time server
18.145.0.30 offset 0.248119 sec
Dec 13 14:35:05 coyote ntpdate[28624]: adjust time server
204.123.2.72 offset 0.156707 sec
Dec 13 15:35:03 coyote ntpdate[29486]: adjust time server
198.30.92.2 offset 0.245309 sec
Dec 13 16:35:04 coyote ntpdate[30400]: adjust time server
164.67.62.194 offset 0.105258 sec
Dec 13 17:35:01 coyote ntpdate[31320]: adjust time server
130.207.244.240 offset 0.036849 sec
Dec 13 18:35:01 coyote ntpdate[32229]: adjust time server
18.145.0.30 offset 0.254626 sec
Dec 13 19:35:10 coyote ntpdate[741]: adjust time server
198.30.92.2 offset 0.276145 sec
Dec 13 20:35:02 coyote ntpdate[1858]: adjust time server
128.252.19.1 offset 0.151181 sec

So while its not perfect, its adequate.

As to whats doing it, I have NDI.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.30% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.

