Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932261AbWELWC6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932261AbWELWC6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 18:02:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932265AbWELWC6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 18:02:58 -0400
Received: from nz-out-0102.google.com ([64.233.162.200]:20287 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932261AbWELWC5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 18:02:57 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=Ci+Ay5bBHjvhgN+hOJX2KkXKJTOf1PBADSkRxV4r443A+PtVuE5vhqTuLeUSv9oLOqCWP3FjW8wkBwmA4T+JBUJzEYtVsQ2YSFhw8GKPghxAJAM3vBYpX3xTKByspbpZ9NEBNwaIjMd/DLnTKscReIc1yLtBg5lrx+MwdDG4lS0=
Message-ID: <446505F8.7020909@gmail.com>
Date: Sat, 13 May 2006 07:02:32 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Stefan Smietanowski <stesmi@stesmi.com>
CC: "Randy.Dunlap" <rdunlap@xenotime.net>, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org
Subject: Re: [ANNOUNCE] libata: new EH, NCQ, hotplug and PM patches against
 stable kernel
References: <20060512132437.GB4219@htj.dyndns.org> <20060512122116.152fbe80.rdunlap@xenotime.net> <4464E079.1070307@stesmi.com>
In-Reply-To: <4464E079.1070307@stesmi.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stefan Smietanowski wrote:
> Randy.Dunlap wrote:
>>> * New error handling
>>> * IRQ driven PIO (from Albert Lee)
>>> * SATA NCQ support
>>> * Hotplug support
>>> * Port Multiplier support
>>
>> BTW, we often use PM to mean Power Management.
>> Could we find a different acronym for Port Multiplier support,
>> such as PMS or PX or PXS?
> 
> Ok, maybe not PMS ?
> 
> Can you imagine a bug report from someone that "has problem with PMS"?
> :)
> 

Would be fun though.  :)

I thought about using another acronym for port multiplier too.  But the 
spec uses that acronym all over the place, PM, PMP (Port Multiplier 
Portnumber), which reminds me of USB full/high speed fiasco.

Urghh... I thought we could use power for power management inside libata 
but that might be a bad idea.  So, PMS?

-- 
tejun
