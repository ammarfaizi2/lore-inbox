Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265869AbTLaAS6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Dec 2003 19:18:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265875AbTLaAS6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Dec 2003 19:18:58 -0500
Received: from sccrmhc12.comcast.net ([204.127.202.56]:9215 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S265869AbTLaAS4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Dec 2003 19:18:56 -0500
Message-ID: <3FF215EE.9000509@why.dont.jablowme.net>
Date: Tue, 30 Dec 2003 19:18:54 -0500
From: Jim Crilly <jim@why.dont.jablowme.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031221 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Helge Hafting <helgehaf@aitel.hist.no>
Cc: Joshua Schmidlkofer <kernel@pacrimopen.com>,
       "David B. Stevens" <dsteven3@maine.rr.com>, Jos Hulzink <josh@stack.nl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.7 (future kernel) wish
References: <200312232342.17532.josh@stack.nl> <20031226233855.GA476@hh.idb.hist.no> <3FECCAF9.7070209@maine.rr.com> <1072507896.27022.226.camel@menion.home> <3FEE47F5.6090406@why.dont.jablowme.net> <20031230142004.GA14655@hh.idb.hist.no>
In-Reply-To: <20031230142004.GA14655@hh.idb.hist.no>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Helge Hafting wrote:
> On Sat, Dec 27, 2003 at 10:03:17PM -0500, Jim Crilly wrote:
> 
>>>Sometimes Windows 2k or XP dump (BSOD), or maybe you just get an error. 
>>>
>>>
>>>
>>
>>Generally it just complains that you pulled out the device prematurely, 
> 
> 
> Depends on what the device is used for, I guess.

Of course different things may happen depending on what's using the 
device, but IME I've never seen the OS give a STOP error from that.

> 
> 
>>I've never seen one give a STOP error from that but I guess a bad driver 
>>or USB controller could cause anything.
>>
> 
> Well, try having a partially loaded system dll on removable
> media when you pull the plug - it won't be pretty.

If you go through all the work to get Windows to use a system file from 
  removable device then pull it out while using it, you deserve what you 
get. The only thing you could do is page in the entire system file if 
you notice it's on a removable device then put a copy in swap for the 
case that someone pulls it out, but I don't think the special case would 
be worth it on Windows or Linux. Not that I have any proof Windows 
doesn't attempt to do that already =)

> 
> 
>>When you insert a device like a USB stick Windows puts a little icon 
>>next to the clock in the system tray that you're supposed to use to stop 
>>the device before pulling it, effectively it unmounts and stops (or 
>>atleast releases the device from) the driver so the device can be 
>>'safely' removed. I also believe Windows mounts any removable device 
>>synchronously so that if you do pull it out prematurely the damage done 
>>is limited.
> 
> 
> Linux has sync mounts too. :-)  the rest is a gui thing, i.e. not kernel.

I know, but I felt like mentioning the rest because it's relevant to a 
number of people on the list.

> 
> Helge Hafting

Jim.
