Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292239AbSBBGu2>; Sat, 2 Feb 2002 01:50:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292240AbSBBGuQ>; Sat, 2 Feb 2002 01:50:16 -0500
Received: from mx1.fuse.net ([216.68.2.90]:21409 "EHLO mta01.fuse.net")
	by vger.kernel.org with ESMTP id <S292239AbSBBGuC>;
	Sat, 2 Feb 2002 01:50:02 -0500
Message-ID: <3C5B8C0D.8090009@fuse.net>
Date: Sat, 02 Feb 2002 01:49:49 -0500
From: Nathan <wfilardo@fuse.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7) Gecko/20020121
X-Accept-Language: en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: Issues with 2.5.3-dj1
In-Reply-To: <3C5B5EC0.40503@fuse.net> <20020202055115.GA11359@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:

>On Fri, Feb 01, 2002 at 10:36:32PM -0500, Nathan wrote:
>
>>System is a Sony VAIO R505JE, kernel 2.5.3-dj1 + preempt + acpi + acpi 
>>pci irq routing.  Debian unstable, updated today.
>>
>>1: USB dies a very similar death in 2.5.3-dj1 as it did in 2.5.2-dj6 
>>(OOPS below and in previous mail).  What else can I provide?
>>
>
>What were you doing with USB at the time?  Unloading the drivers?  What
>USB host controller, and USB drivers were you using?
>
>And the most important of all, does this also happen in 2.5.3?
>
>thanks,
>
>greg k-h
>
Yeah, this was at system shutdown (/etc/init.d/hotplug stop) - I have 
USB compiled as modules, so I presume they auto-unloaded?  I've got no 
USB devices attached, so that's easy, and I use the UHCI driver (not the 
alternate driver - should I try that one or is this a lower level problem?).

Alright... a 2.5.3 with no extras boots fine (with init=/bin/bash) and 
can load and unload hotplug several times without OOPSing.  So it 
appears to be something else.  Hope that helps.

--Nathan

--Nathan


