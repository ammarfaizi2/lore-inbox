Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261420AbVD3VCN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261420AbVD3VCN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Apr 2005 17:02:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261427AbVD3VCN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Apr 2005 17:02:13 -0400
Received: from smtp-roam.Stanford.EDU ([171.64.10.152]:31105 "EHLO
	smtp-roam.Stanford.EDU") by vger.kernel.org with ESMTP
	id S261420AbVD3VCJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Apr 2005 17:02:09 -0400
Message-ID: <4273F24C.3040202@myrealbox.com>
Date: Sat, 30 Apr 2005 14:02:04 -0700
From: Andy Lutomirski <luto@myrealbox.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: bert hubert <ahu@ds9a.nl>
CC: Andy Lutomirski <luto@myrealbox.com>, linux-kernel@vger.kernel.org
Subject: Re: [x86_64] how worried should I be about MCEs?
References: <4273E7B1.6020500@myrealbox.com> <20050430203723.GA8122@outpost.ds9a.nl>
In-Reply-To: <20050430203723.GA8122@outpost.ds9a.nl>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

bert hubert wrote:
> On Sat, Apr 30, 2005 at 01:16:49PM -0700, Andy Lutomirski wrote:
> 
>>Every now and then, after rebooting, the kernel notices some MCEs. 
>>Should I be worried about this?
> 
> 
> If these reports are true, they would be worrying. But I find them a bit
> hard to believe - the bit combinations don't appear to make sense.

True.

> 
> I have an AMD64 machine which logs 'MCE reported' every once in a while but
> otherwise functions perfectly and I haven't yet coaxed it into telling me
> the content of the errors.
> 
> Might there be a bug here? How did you create this log?

This is from mcelog 0.3, dumped with a daily cron job to 
/var/log/mcelog.  I think it came from 2.6.11-gentoo-r6 (which should be 
essentially 2.6.11.7).

The machine is Athlon 64 3200+ (754), on an MSI K8T Neo-FIS2R, running a 
moderately old BIOS but one that has erratum #93 (or whatever it was) fixed.

Anything I should attach to provide more info?

I just upgraded to mcelog-0.4, but at this rate I don't expect a new 
dump for awhile.

Thanks,
Andy
