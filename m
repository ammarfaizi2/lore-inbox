Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932241AbVL0Fzz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932241AbVL0Fzz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Dec 2005 00:55:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932244AbVL0Fzz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Dec 2005 00:55:55 -0500
Received: from thing.hostingexpert.com ([67.15.235.34]:45779 "EHLO
	thing.hostingexpert.com") by vger.kernel.org with ESMTP
	id S932241AbVL0Fzz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Dec 2005 00:55:55 -0500
Message-ID: <43B0D789.6060208@gmail.com>
Date: Tue, 27 Dec 2005 00:56:25 -0500
From: Michael Krufky <mkrufky@gmail.com>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Lee Revell <rlrevell@joe-job.com>
CC: Mark Knecht <markknecht@gmail.com>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Ho ho ho.. Linux 2.6.15-rc7
References: <Pine.LNX.4.64.0512241930370.14098@g5.osdl.org>	 <5bdc1c8b0512261002n6167a78ewfc45a6d3a5078ac0@mail.gmail.com> <1135620892.8293.60.camel@mindpipe>
In-Reply-To: <1135620892.8293.60.camel@mindpipe>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - thing.hostingexpert.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - gmail.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell wrote:

>On Mon, 2005-12-26 at 10:02 -0800, Mark Knecht wrote:
>  
>
>>Hi Linus,
>>   I've visiting at my parents house and gave 2.6.15-rc7 a try on my
>>dad's machine. This machine is his normal desktop box which I
>>administer remotely, as well as a MythTV server. The new kernel built
>>and booted fine. I then built the NVidia stuff. However when I tried
>>to build the ivtv driver from portage it failed:
>>    
>>
>There's nothing the kernel developers can do about regressions in out of
>tree modules - there is no stable kernel module API so the authors of
>that module will have to fix it.
>
>Any idea why the IVTV module has not been submitted for mainline?
>
Little by little, ivtv is being merged into V4L.  There is a lot of 
reorganization that is taking place, and it is not a very fast process.

As of 2.6.15-rc1, many of the modules from ivtv were merged into the 
kernel through V4L.  Recently, there was another ivtv fork discovered, 
called paken.  (for better details, see ivtv mailing list archives)  The 
ivtv guys are currently working on cleaning up the main ivtv module, and 
merging in the code from the paken repo.  When all is ready, it will all 
be merged into v4l, and eventually the kernel.

Cheers,

Michael Krufky
