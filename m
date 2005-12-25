Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750857AbVLYP4X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750857AbVLYP4X (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Dec 2005 10:56:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750858AbVLYP4X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Dec 2005 10:56:23 -0500
Received: from mail.dvmed.net ([216.237.124.58]:51657 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750856AbVLYP4W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Dec 2005 10:56:22 -0500
Message-ID: <43AEC119.8080109@pobox.com>
Date: Sun, 25 Dec 2005 10:56:09 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: gcoady@gmail.com
CC: Ed Tomlinson <edt@aei.ca>, Mark Lord <lkml@rtr.ca>,
       Justin Piszcz <jpiszcz@lucidpixels.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.15-rc6 - Success with ICH5/SATA + S.M.A.R.T.
References: <Pine.LNX.4.64.0512241830010.2700@p34> <43ADDD34.9020101@rtr.ca> <200512250937.55140.edt@aei.ca> <43AEB0CB.20403@pobox.com> <sfftq1lhi7dvugooro7mjthksiqc6j8mg0@4ax.com>
In-Reply-To: <sfftq1lhi7dvugooro7mjthksiqc6j8mg0@4ax.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 1.5 (+)
X-Spam-Report: Spam detection software, running on the system "srv2.dvmed.net", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Grant Coady wrote: > On Sun, 25 Dec 2005 09:46:35
	-0500, Jeff Garzik <jgarzik@pobox.com> wrote: > > >>Ed Tomlinson wrote:
	>> >>>On Saturday 24 December 2005 18:43, Mark Lord wrote: >>> >>>
	>>>>>smartmontools is going to have to be updated >>>> >>>>What for?
	>>>> >>>>Use "smartctl -d ata /dev/sda" >>> >>> >>>Its not perfect: >>>
	>>>grover:/poola/home/ed# smartctl -d ata /dev/sda >>>smartctl version
	5.34 [x86_64-unknown-linux-gnu] Copyright (C) 2002-5 Bruce Allen
	>>>Home page is http://smartmontools.sourceforge.net/ >>> >>>smartctl
	has problems but hddtemp works >> >>What are the problems? Your output
	gives us no clue... > > > That _is_ the clue, no output ;) [...] 
	Content analysis details:   (1.5 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	1.3 GAPPY_SUBJECT          Subject: contains G.a.p.p.y-T.e.x.t
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[69.134.188.146 listed in dnsbl.sorbs.net]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Grant Coady wrote:
> On Sun, 25 Dec 2005 09:46:35 -0500, Jeff Garzik <jgarzik@pobox.com> wrote:
> 
> 
>>Ed Tomlinson wrote:
>>
>>>On Saturday 24 December 2005 18:43, Mark Lord wrote:
>>>
>>>
>>>>>smartmontools is going to have to be updated
>>>>
>>>>What for?
>>>>
>>>>Use "smartctl -d ata /dev/sda"
>>>
>>>
>>>Its not perfect:
>>>
>>>grover:/poola/home/ed# smartctl -d ata /dev/sda
>>>smartctl version 5.34 [x86_64-unknown-linux-gnu] Copyright (C) 2002-5 Bruce Allen
>>>Home page is http://smartmontools.sourceforge.net/
>>>
>>>smartctl has problems but hddtemp works
>>
>>What are the problems?  Your output gives us no clue...
> 
> 
> That _is_ the clue, no output ;)  

Perhaps if the poster provided a useful command line to smartctl, it 
would do useful work.

If you don't provide a command to smartctl, it won't do much of anything:

> [jgarzik@sata ~]$ sudo smartctl  /dev/hda1
> smartctl version 5.33 [i386-redhat-linux-gnu] Copyright (C) 2002-4 Bruce Allen
> Home page is http://smartmontools.sourceforge.net/

> [jgarzik@sata ~]$ sudo smartctl -d ata /dev/sda1
> smartctl version 5.33 [i386-redhat-linux-gnu] Copyright (C) 2002-4 Bruce Allen
> Home page is http://smartmontools.sourceforge.net/

Regards,

	Jeff


