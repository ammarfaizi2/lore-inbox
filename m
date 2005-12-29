Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932559AbVL2A3n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932559AbVL2A3n (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Dec 2005 19:29:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932563AbVL2A3n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Dec 2005 19:29:43 -0500
Received: from smtp-out4.blueyonder.co.uk ([195.188.213.7]:40215 "EHLO
	smtp-out4.blueyonder.co.uk") by vger.kernel.org with ESMTP
	id S932559AbVL2A3m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Dec 2005 19:29:42 -0500
Message-ID: <43B32DEE.7010405@blueyonder.co.uk>
Date: Thu, 29 Dec 2005 00:29:34 +0000
From: Sid Boyce <sboyce@blueyonder.co.uk>
Reply-To: sboyce@blueyonder.co.uk
Organization: blueyonder.co.uk
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Tarkan Erimer <tarkane@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [BUG]: Hard lockups continue with linux-2.6.15-rc1-rc7
References: <43B06063.8030909@blueyonder.co.uk> <9611fa230512281606y4ae3e163u43742b5146c71161@mail.gmail.com>
In-Reply-To: <9611fa230512281606y4ae3e163u43742b5146c71161@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 29 Dec 2005 00:30:37.0090 (UTC) FILETIME=[16A9B020:01C60C0F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tarkan Erimer wrote:
> Hi Sid,
> 
> On 12/26/05, Sid Boyce <sboyce@blueyonder.co.uk> wrote:
>> Don't rule out hardware. This SuSE 10.0 x86 box worked without problems
>> on kernels up to 2.6.15-rc6-git2, but I experienced strange apparent
>> filesystem corruptions/compile failures running normally and hard
>> lockups when running mythtv with 2.6.15-rc6-git6 and 2.6.15-rc7, while
>> on the Mandriva 2006 x86 box and the SuSE x86_64 there were no problems.
>> Until I found the suspect SDRAM, on some occasions I had to run
>> reiserfsck before 2.6.15-rc6-git2 would boot again correctly after
>> trying rc6-git6 or -rc7. Finally I got a corruption again with
>> 2.6.15-rc7, replaced the SDRAM stick with the one taken out previously,
>> booted up on 2.6.15-rc7 with no problems. I had run memtest some days
>> earlier, but only for a couple of hours. (current uptime 1 day 1.04hrs).
> 
> Hmmm.. It looks, it is time to run memtest on my box. Thanks for the tip.
> 
> Regards,
> 
> 
It's strongly recommended. I've now found that both SDRAMS with the same 
batch number are experiencing the same error with memtest, that's after 
I had a lockup with the one I thought was good. They will be replaced 
under lifetime warranty by Kingston memory. I've temporarily stuck a 
PC2700 512M stick in and it's been solid under memtest and with a full 
workload.
Regards
Sid.
-- 
Sid Boyce ... Hamradio License G3VBV, Licensed Private Pilot
Retired IBM/Amdahl Mainframes and Sun/Fujitsu Servers Tech Support 
Specialist, Cricket Coach
Microsoft Windows Free Zone - Linux used for all Computing Tasks
