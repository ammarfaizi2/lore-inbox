Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261298AbUDGX5p (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 19:57:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264211AbUDGX5b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 19:57:31 -0400
Received: from smtp-out6.blueyonder.co.uk ([195.188.213.9]:30801 "EHLO
	smtp-out6.blueyonder.co.uk") by vger.kernel.org with ESMTP
	id S261298AbUDGX4N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 19:56:13 -0400
Message-ID: <4074951A.8010900@blueyonder.co.uk>
Date: Thu, 08 Apr 2004 00:56:10 +0100
From: Sid Boyce <sboyce@blueyonder.co.uk>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040208)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: CONFIG_4KSTACKS in mm2?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 07 Apr 2004 23:56:14.0156 (UTC) FILETIME=[E8D070C0:01C41CFB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ralf Hindlebrand wrote:
* Zwane Mwaikambo <zwane@xxxxxxxxxxxxx>:

 > >/ > That's what I did (and it works) -- but it's not really 
intuitive or/
 > >/ > even configurable (in the way of menuconfig or something)./
 >/  >/
 > >/ Andrew Morton turned it on unconditionally on purpose for wider 
testing./

 > Yep. It doesn't work with Nvidia's nvidia kernel drivers. But what's
 > new :)

What's new is that I forgot to turn it off, I'd been running 2.6.5-cko1, 
built 2.6.5-mm1, booted up and installed nvidia kernel for it. I ended 
up with a trashed HD which needed reformatiing and a fresh install. I 
don't know what symptoms I should have seen, perhaps nvidia failing to 
work. I suspect it was a combination of 4K_STACKS and some hardware bug 
for which I am going to change the motherboard, memory and Athlon CPU as 
I've had odd hangs during boot. A few boots hung, finally I disabled 
level 2 cache and it came up, so I think I will leave the next bootup 
till the new stuff is installed. I previously had a hard drive that 
would not boot fully after starting X with nvidia, though it's mountable 
as hdc1 and I can get at all the stuff I need.
Regards
Sid.

