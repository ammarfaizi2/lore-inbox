Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261991AbVCNWOy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261991AbVCNWOy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 17:14:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262028AbVCNWLW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 17:11:22 -0500
Received: from warden-p.diginsite.com ([208.29.163.248]:6281 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP id S261991AbVCNWIl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 17:08:41 -0500
From: David Lang <david.lang@digitalinsight.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Jesse Barnes <jbarnes@engr.sgi.com>, Pavel Machek <pavel@ucw.cz>,
       Dave Jones <davej@redhat.com>,
       OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
       Linus Torvalds <torvalds@osdl.org>, Paul Mackerras <paulus@samba.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Date: Mon, 14 Mar 2005 14:08:07 -0800 (PST)
X-X-Sender: dlang@dlang.diginsite.com
Subject: Re: dmesg verbosity [was Re: AGP bogosities]
In-Reply-To: <1110837341.5863.21.camel@gaston>
Message-ID: <Pine.LNX.4.62.0503141403190.10882@qynat.qvtvafvgr.pbz>
References: <16944.62310.967444.786526@cargo.ozlabs.ibm.com><Pine.LNX.4.62.0503140026360.10211@qynat.qvtvafvgr.pbz><20050314083717.GA19337@elf.ucw.cz><200503140855.18446.jbarnes@engr.sgi.com>
 <1110837341.5863.21.camel@gaston>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Mar 2005, Benjamin Herrenschmidt wrote:

>> We already have the 'quiet' option, but even so, I think the kernel is *way*
>> too verbose.  Someone needs to make a personal crusade out of removing
>> unneeded and unjustified printks from the kernel before it really gets better
>> though...
>
> Oh well, I admit going backward here with my new radeonfb which will be
> very verbose in a first release, but that will be necessary to track
> down all the various issues with monitor detection, BIOSes telling crap
> about connectors etc...

This isn't the problem, the fact that if I have all the encryption modes 
turned on I get several hundred lines of output telling me that it tested 
the encryption and got the result it expected is.

you are turning up the verbosity becouse it's needed, if you don't turn it 
down in a few releases (assuming you fix the problems by then ;-) then you 
would become part of the problem.

back in the 1.3/2.0 days when I started useing linux I was a PC repair 
technition and when working on the windows PC's I would use a linux boot 
disk to identify the hardware that was in the machine based on the dmesg 
output (and the ports things were on) so that I could configure the 
windows drivers. So it's not that I can't understand the value of the 
dmesg output, it's that there is now so much additional data that it's no 
longer reasonable to see what's going on.

when the boot dmesg output overflows the 500 line buffer of a VGA console 
so that you can not scroll back and see the messages by the time the 
system starts things have gotten too verbose.

David Lang

-- 
There are two ways of constructing a software design. One way is to make it so simple that there are obviously no deficiencies. And the other way is to make it so complicated that there are no obvious deficiencies.
  -- C.A.R. Hoare
