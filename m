Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967766AbWLEXbL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967766AbWLEXbL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 18:31:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967760AbWLEXbK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 18:31:10 -0500
Received: from mx1.redhat.com ([66.187.233.31]:49541 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S967766AbWLEXbJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 18:31:09 -0500
Message-ID: <4576004C.2090304@redhat.com>
Date: Tue, 05 Dec 2006 18:27:08 -0500
From: =?UTF-8?B?S3Jpc3RpYW4gSMO4Z3NiZXJn?= <krh@redhat.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060803)
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: Erik Mouw <erik@harddisk-recovery.com>, linux-kernel@vger.kernel.org,
       Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: [PATCH 0/3] New firewire stack
References: <20061205052229.7213.38194.stgit@dinky.boston.redhat.com>	 <1165308400.2756.2.camel@localhost> <45758CB3.80701@redhat.com>	 <20061205160530.GB6043@harddisk-recovery.com> <1165337635.2756.31.camel@localhost>
In-Reply-To: <1165337635.2756.31.camel@localhost>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcel Holtmann wrote:
> Hi Erik,
> 
>>>> can you please use drivers/firewire/ if you want to start clean or
>>>> aiming at replacing drivers/ieee1394/. Using "fw" as an abbreviation in
>>>> the directory path is not really helpful.
>>> Yes, that's probably a better idea.  Do you see a problem with using fw_* 
>>> as a prefix in the code though?  I don't see anybody using that prefix, but 
>>> Stefan pointed out to me that it's often used to abbreviate firmware too.
>> So what about fiwi_*? If that's too close to wifi_*, try frwr_.
> 
> please don't. These kind of abbreviations make my brain tilt. For the
> directory name you basically should use the full name. In this case it
> will be drivers/ieee1394/ or drivers/firewire/. Nothing else is really
> acceptable and if you look at other subsystems, you will see that they
> always use the long name.
> 
> For the exported public functions you might wanna use abbreviations, but
> in general I don't recommend it. And normally we only talk about a
> limited functions that are needed to be exposed via EXPORT_SYMBOL.

I think I'll stick with my fw_* prefix for now, it's nice and short and not 
too cryptic.  I'm only exporting a small set of functions anyway, and they're 
all only used inside the firewire stack.

Kristian

