Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262125AbUKVQm0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262125AbUKVQm0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 11:42:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262169AbUKVQlS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 11:41:18 -0500
Received: from fire.osdl.org ([65.172.181.4]:41378 "EHLO fire-1.osdl.org")
	by vger.kernel.org with ESMTP id S262125AbUKVQPQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 11:15:16 -0500
Message-ID: <41A20D5A.6040004@osdl.org>
Date: Mon, 22 Nov 2004 08:01:30 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
Organization: OSDL
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Stelian Pop <stelian@popies.net>
CC: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>,
       Christoph Hellwig <hch@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, greg@kroah.com
Subject: Re: [PATCH] usb-storage should enable scsi disk in Kconfig
References: <20041119193350.GE2700@deep-space-9.dsnet> <20041119195736.GA8466@infradead.org> <20041119213942.GG2700@deep-space-9.dsnet> <20041119230820.GB32455@one-eyed-alien.net> <419FD192.1040604@osdl.org> <20041122103520.GA3550@crusoe.alcove-fr>
In-Reply-To: <20041122103520.GA3550@crusoe.alcove-fr>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stelian Pop wrote:
> On Sat, Nov 20, 2004 at 03:21:54PM -0800, Randy.Dunlap wrote:
> 
> 
>>>>>On Fri, Nov 19, 2004 at 08:33:50PM +0100, Stelian Pop wrote:
>>>>
>>>>Maybe we should add, just below the 'USB storage' Kconfig option another
>>>>one, let's say 'SCSI disk based USB storage support', which documentation
>>>>would talk about 'usb keys, memory stick readers, USB floppy drives etc',
>>>>which should just be a dummy option selecting  BLK_DEV_SD ?
> 
> 
>>Until 'suggests' is available, does this help any?
>>It's tough getting people to read Help messages though.
>>
>>Add comment/NOTE that USB_STORAGE probably needs BLK_DEV_SD also.
>>Add a few device types to help text and reformat it.
> 
> 
> Isn't my above suggestion even better ? A separate config option
> is much more visible IMHO...

Sounds good, as long as we don't mind the same option being
settable in multiple places.  Did you submit a patch?

-- 
~Randy
