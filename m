Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751417AbVH2XSJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751417AbVH2XSJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Aug 2005 19:18:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751416AbVH2XSJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Aug 2005 19:18:09 -0400
Received: from relay01.mail-hub.dodo.com.au ([203.220.32.149]:58761 "EHLO
	relay01.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S1751411AbVH2XSH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Aug 2005 19:18:07 -0400
From: gcoady@gmail.com
To: "Miller, Mike (OS Dev)" <Mike.Miller@hp.com>
Cc: "Christoph Hellwig" <hch@infradead.org>, <linux-scsi@vger.kernel.org>,
       <linux-kernel@vger.kernel.org>, <greg@kroah.com>, <mochel@osdl.org>,
       "Moore, Eric Dean" <Eric.Moore@lsil.com>,
       "Patterson, Andrew D (Linux R&D)" <andrew.patterson@hp.com>,
       "Luben Tuikov" <luben_tuikov@adaptec.com>
Subject: Re: 2.6: how do I this in sysfs?
Date: Tue, 30 Aug 2005 09:17:41 +1000
Organization: http://bugsplatter.mine.nu/
Message-ID: <mm57h19bgaf3bj3rrvi6ps24k0inaei55q@4ax.com>
References: <D4CFB69C345C394284E4B78B876C1CF10ABB0269@cceexc23.americas.cpqcorp.net>
In-Reply-To: <D4CFB69C345C394284E4B78B876C1CF10ABB0269@cceexc23.americas.cpqcorp.net>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Aug 2005 12:24:18 -0500, "Miller, Mike (OS Dev)" <Mike.Miller@hp.com> wrote:

>
>> This is after my minimal sas transport class, please also 
>> read the thread about it on linux-scsi
>> 
>In the referenced code for using sysfs, there only appear to be methods
>for reading attributes.  How about if we want to cause a command to
>get written out to the hardware?   Do we do something like this?
>
>        /* get a semaphore keep everyone else out while we're working,
>           and hope like hell that all the other processes are playing
>           nice and using the semaphore too, or else we're hosed. */
>
[...]
>        release_some_kind_of_semaphore();
>
>I'm not suggesting that the above is a good idea.  I don't have a good
>idea about how to do this.

Take a look at hwmon drivers, it is nowhere near so bad as you think.

Grant.

