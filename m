Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030419AbWFVWPz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030419AbWFVWPz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 18:15:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030420AbWFVWPz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 18:15:55 -0400
Received: from [80.96.155.2] ([80.96.155.2]:25288 "EHLO aladin.ro")
	by vger.kernel.org with ESMTP id S1030419AbWFVWPy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 18:15:54 -0400
Message-ID: <449B4181.9060907@aladin.ro>
Date: Fri, 23 Jun 2006 01:18:57 +0000
From: Eduard-Gabriel Munteanu <maxdamage@aladin.ro>
User-Agent: Mozilla Thunderbird 1.0.5 (X11/20050719)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Olivier Galibert <galibert@pobox.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Is the x86-64 kernel size limit real?
References: <20060622204627.GA47994@dspnet.fr.eu.org> <449B355C.2080805@aladin.ro> <20060622215205.GA52945@dspnet.fr.eu.org>
In-Reply-To: <20060622215205.GA52945@dspnet.fr.eu.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

*This message was transferred with a trial version of CommuniGate(r) Pro*
Olivier Galibert wrote:
> *This message was transferred with a trial version of CommuniGate(r) Pro*
> *This message was transferred with a trial version of CommuniGate(r) Pro*
> On Fri, Jun 23, 2006 at 12:27:08AM +0000, Eduard-Gabriel Munteanu wrote:
> 
>>*This message was transferred with a trial version of CommuniGate(r) Pro*
>>Olivier Galibert wrote:
>>
>>
>>>which shows two things:
>>>1- a8f5034540195307362d071a8b387226b410469f should have a x86-64 version
>>>2- the limit looks entirely artificial
>>>
>>>So, is removing the limit prone to bite me?
>>>
>>> OG.
>>
>>The build system merely tries to warn you it's not going to fit on a 
>>floppy disk. "bzImage" means "Big zImage", not "bz2-compressed Image", 
>>so unless you're building a floppy disk, don't use zImage.
> 
> 
> You failed to notice the "is_big_kernel ? 0x40000 : ..." part, which
> means the 4Mb limit is for bzImage.  And the "die(...)" part, which
> means it's not a warning but an error.
> 

Sorry, I thought it was you who made that patch.
