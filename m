Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932072AbVHLJxw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932072AbVHLJxw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 05:53:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932087AbVHLJxw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 05:53:52 -0400
Received: from embla.aitel.hist.no ([158.38.50.22]:18092 "HELO
	embla.aitel.hist.no") by vger.kernel.org with SMTP id S932072AbVHLJxv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 05:53:51 -0400
Message-ID: <42FC7372.7040607@aitel.hist.no>
Date: Fri, 12 Aug 2005 12:01:22 +0200
From: Helge Hafting <helge.hafting@aitel.hist.no>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: Dave Airlie <airlied@gmail.com>, Linus Torvalds <torvalds@osdl.org>,
       akpm@osdl.org
Subject: rc6 keeps hanging and blanking displays where rc4-mm1 works fine.
References: <Pine.LNX.4.58.0508012201010.3341@g5.osdl.org>	 <20050805104025.GA14688@aitel.hist.no> <21d7e99705080503515e3045d5@mail.gmail.com> <42F89F79.1060103@aitel.hist.no>
In-Reply-To: <42F89F79.1060103@aitel.hist.no>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Helge Hafting wrote:

> Dave Airlie wrote:
>
>>
>>     I switched back to 2.6.13-rc4-mm1 at this point for another reason,
>>     my X display aquired a nasty tendency to go blank for no reason
>>     during work,
>>     something I could fix by changing resolution baqck and forth.  X
>>     also tended to get
>>     stuck for a minute now and then - a problem I haven't seen since
>>     early 2.6.
>>
>>
>>
>> which head the radeon or MGA or both?
>
>
> The radeon 9200SE-pci gets stuck.  The MGA-agp seems to be fine. I 
> have compiled
> dri support for both, but I can't use it at the moment.  I think that is
> caused by having ubuntu's xorg installed on debian.  I needed xorg
> in order to run an xserver that doesn't use any tty - this way I can use
> two keyboards and have two simultaneous users. Debians xorg wasn't ready
> at the moment. The setup is fine with 2.6.13-rc4-mm1 x86-64, no 
> problems there.

The problem still exists in 2.6.13-rc6.  Usually, all I get is a 
suddenly black display,
solveable by resizing.  But the machine will occationally hang, forcing 
me to
use the reset button.  I lost my mbox file to this (from an ext3 fs, on 
raid-1 on scsi.)

It is hard to say wether the fs problem merely is an effect of hanging 
with rc6.
With rc5, there definitely was some sort of io/scsi problem as one disk
was "lost" until I booted a working kernel.

Currently, it seems like I won't be able to use 2.6.13.

Helge Hafting
