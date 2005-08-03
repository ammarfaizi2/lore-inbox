Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262430AbVHCTzT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262430AbVHCTzT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 15:55:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262432AbVHCTzT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 15:55:19 -0400
Received: from Mail.MNSU.EDU ([134.29.1.12]:63686 "EHLO mail.mnsu.edu")
	by vger.kernel.org with ESMTP id S262430AbVHCTzQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 15:55:16 -0400
Message-ID: <42F12100.5020006@mnsu.edu>
Date: Wed, 03 Aug 2005 14:54:40 -0500
From: Jeffrey Hundstad <jeffrey.hundstad@mnsu.edu>
User-Agent: Debian Thunderbird 1.0.6 (X11/20050802)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
CC: linux-kernel@vger.kernel.org, ck@vds.kolivas.org, tony@atomide.com,
       tuukka.tikkanen@elektrobit.com
Subject: Re: [PATCH] i386 No-Idle-Hz aka Dynamic-Ticks 3
References: <200508031559.24704.kernel@kolivas.org>
In-Reply-To: <200508031559.24704.kernel@kolivas.org>
X-Enigmail-Version: 0.92.0.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote:

>This is the dynamic ticks patch for i386 as written by Tony Lindgen 
><tony@atomide.com> and Tuukka Tikkanen <tuukka.tikkanen@elektrobit.com>. 
>Patch for 2.6.13-rc5
>
>There were a couple of things that I wanted to change so here is an updated 
>version. This code should have stabilised enough for general testing now.
>
>The sysfs interface was moved to its own directory 
>in /sys/devices/system/dyn_tick and split into separate files to 
>enable/disable dynamic ticks and usage of apic on the fly. It makes sense to 
>enable dynamic ticks and usage of apic by default if they're actually built 
>into the kernel so that is now done.
>  
>

I am successfully running the dynamic tick patch on an old IBM ThinkPad 
A22m.  When I enable the APIC support console beeps, you know bash -c 
'echo -e "\a"', takes a REALLY long time to finish.  I'm assuming this 
is a badly written program and not a kernel problem.  Correct?

BTW: how do you know what HZ your machine is running at?

-- 
Jeffrey Hundstad

