Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261791AbVGZOsZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261791AbVGZOsZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 10:48:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261825AbVGZOsY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 10:48:24 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:1543 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S261791AbVGZOsX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 10:48:23 -0400
Message-ID: <42E64E2D.7010700@tmr.com>
Date: Tue, 26 Jul 2005 10:52:29 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050511
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Brown, Len" <len.brown@intel.com>
CC: Pavel Machek <pavel@ucw.cz>, jesper.juhl@gmail.com,
       linux-kernel@vger.kernel.org,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Subject: Re: 2.6.13-rc3 Battery times at 100/250/1000 Hz = Zero difference
References: <F7DC2337C7631D4386A2DF6E8FB22B300424AE32@hdsmsx401.amr.corp.intel.com>
In-Reply-To: <F7DC2337C7631D4386A2DF6E8FB22B300424AE32@hdsmsx401.amr.corp.intel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brown, Len wrote:
>  
> 
>>>>Digging up this patch from last month regarding C2
>>>>on a AMD K7 implies
>>>>that the whole blame can be put on kernel acpi:
>>>>
>>>>http://marc.theaimsgroup.com/?l=linux-kernel&m=111933745131301&w=2
> 
> 
> The current Linus tree includes generic ACPI support
> for deep C-states on SMP machines. (deep means higher than C1)
> 
> I don't have any problem with people having platform specific
> modules to handle platform specific features.  However, if
> the system really intends to support SMP ACPI C-states deeper
> than C1 and the generic ACPI code doesn't support it,
> then it is either a Linux/ACPI bug or a BIOS bug -- file away:-)
> 
> I.e. The whole concept of ACPI is that you shoulud _not_ need
> a platform specific driver to accomplish this.

Is anyone but me interested in low power states for servers? I have 
several groups of servers which are lightly utilized for at least 12 
hours every day and on weekends. I currently use IDE drives so I can 
spin them down when idle, do logging either to a single drive or over 
the network whichever makes the most sense, and any drop in power use 
saves double, since I pay for the server power and the A/C power as well.

I haven't seen much discussion of this, but in many cases it would 
result in a saving, perhaps fairly large. Some environmental benefit as 
well, of course.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
