Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964863AbWBGAUM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964863AbWBGAUM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 19:20:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932419AbWBGAUM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 19:20:12 -0500
Received: from rtr.ca ([64.26.128.89]:28641 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S932389AbWBGAUK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 19:20:10 -0500
Message-ID: <43E7E7B2.90909@rtr.ca>
Date: Mon, 06 Feb 2006 19:20:02 -0500
From: Mark Lord <lkml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.1) Gecko/20060130 SeaMonkey/1.0
MIME-Version: 1.0
To: Pavel Machek <pavel@suse.cz>
Cc: Nigel Cunningham <nigel@suspend2.net>, Rafael Wysocki <rjw@sisk.pl>,
       linux-kernel@vger.kernel.org,
       Suspend2 Devel List <suspend2-devel@lists.suspend2.net>
Subject: Re: Which is simpler? (Was Re: [Suspend2-devel] Re: [ 00/10] [Suspend2]
 Modules support.)
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <200602041954.22484.nigel@suspend2.net> <20060204192924.GC3909@elf.ucw.cz> <200602061402.54486.nigel@suspend2.net> <20060206105954.GD3967@elf.ucw.cz> <43E761EB.3030203@rtr.ca> <20060206145224.GC1675@elf.ucw.cz>
In-Reply-To: <20060206145224.GC1675@elf.ucw.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> On Po 06-02-06 09:49:15, Mark Lord wrote:
>>> I'm not sure if we want to save full image of memory. Saving most-used
>>> caches only seems to work fairly well.
>> No, it sucks.  My machines take forever to become usable on resume
>> with the current method.  But dumping full image of memory will need
>> compression to keep that from being sluggish as well.
> 
> Are you sure? This changed recently, be sure to set
> /sys/power/image_size.

No such pathname in 2.6.15 (the latest released kernel).

Cheers
