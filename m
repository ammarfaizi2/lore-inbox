Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315172AbSD2Tkx>; Mon, 29 Apr 2002 15:40:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315171AbSD2Tkv>; Mon, 29 Apr 2002 15:40:51 -0400
Received: from jffdns02.or.intel.com ([134.134.248.4]:49631 "EHLO
	hebe.or.intel.com") by vger.kernel.org with ESMTP
	id <S315170AbSD2Tkt>; Mon, 29 Apr 2002 15:40:49 -0400
Message-ID: <59885C5E3098D511AD690002A5072D3C02AB7DF0@orsmsx111.jf.intel.com>
From: "Grover, Andrew" <andrew.grover@intel.com>
To: "'Andrew Theurer'" <habanero@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: RE: Hyperthreading and physical/logical CPU identification
Date: Mon, 29 Apr 2002 12:40:42 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Andrew Theurer [mailto:habanero@us.ibm.com] 
> I would like to know if there is any way to confirm that I have 
> hyperthreading enabled, and my P4 CPUs are hyperthreaded.  
> Actually, from 
> something like /proc/cpuinfo, I'd like to figure out if I am 
> seeing 2/4 
> physical/logical processors, as a result from hyperthreading, or 4/4 
> physical/logical processors with no hyperthreading.  I know, 
> "If it's double 
> the number of physical processors, well you have 
> hyperthreading enabled."  
> The problem is, I have 4 physical processors, but kernel.org 
> kernels so far 
> do not recognize all of them.  2.4.18 will find 3, while 
> 2.5.11 will find 
> only 2 (BIOS hyperthreading support off, no acpismp=force).  
> However, on 
> 2.5.11, if I enable hyperthreading (thru BIOS and 
> acpismp=force, I see 4 
> processors.  
> 
> I would very much like to believe that in this configuration, 
> I am only 
> running on 2 physical, 4 logical processors, but I am getting a 31% 
> improvement (netbench) when hyperthreading is enabled.  Thats 
> why I want to 
> confirm I am really only using 2 physical, 4 logical 
> processors.  Is there 
> any way I can do this? (dmesg? /proc/cpuinfo?)

Well the two alternatives are, either A) turning on hyperthreading enabled
the two virtual processors or B) turning on hyperthreading somehow enabled
the other two processors, right?

I would think B would be highly unlikely.

Anyone else who actually has HT hardware care to comment? ;-)

Regards -- Andy
