Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131261AbRDBVVt>; Mon, 2 Apr 2001 17:21:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131296AbRDBVVa>; Mon, 2 Apr 2001 17:21:30 -0400
Received: from zeus.kernel.org ([209.10.41.242]:43725 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S131261AbRDBVVV>;
	Mon, 2 Apr 2001 17:21:21 -0400
From: "Richard A. Smith" <rsmith@bitworks.com>
To: "adrian@humboldt.co.uk" <adrian@humboldt.co.uk>
Cc: "andre@linux-ide.org" <andre@linux-ide.org>,
   "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
   "Padraig Brady" <Padraig@AnteFacto.com>,
   "Steffen Grunewald" <steffen@gfz-potsdam.de>
Date: Mon, 02 Apr 2001 16:19:25 -0500
Reply-To: "Richard A. Smith" <rsmith@bitworks.com>
X-Mailer: PMMail 2000 Professional (2.20.2030) For Windows 98 (4.10.2222)
In-Reply-To: <3AC8E633.9070503@humboldt.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Subject: Re: Cool Road Runner (was CFA as Ide.)
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
X-Return-Path: RSmith@bitworks.com
Message-ID: <MDAEMON-F200104021623.AA231904MD92067@bitworks.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 02 Apr 2001 21:50:59 +0100, Adrian Cox wrote:

>> IIRC SanDisk was the original people to come out with IDE CFA and everyone
>> else just copied them.  I have the SanDisk datasheets that I can send you
>> if you need them to verify stuff.  I believe that if you verify it with 
>> the SanDisk then all the other MFG's should work as well.
>
>If only. In my limited experience SanDisk cards have been the most 
>tolerant. I suspect that Sandisk actually implement the full range of 
>timings documented in the spec, and nobody else bothers.
>
>This isn't normally a problem on PC hardware, but if you try to 
>implement an interface to talk to a CF card in an embedded system you 
>find this out.

Hmmm... most of our embedded systems are based on a PC somehow either via a processor card or  
an actual PC system that we design so perhaps I have't stressed the limits yet.

We do actually use SST (Silcon Storage Technolog) CF's as well and they seem to function just 
identical to the SanDisk but not quite as robust... I have had several of the SST's develope 
a problem in the partition table and as thus the just error when you try to mount them.
Several people on the liunx-embedded list also have similar experiences.

That seems to follow your observations...

Will it be worth while for you if I break out the scope and examine how our CF's handle the 
PDIAG signal or can we just go on faith that they do indeed work as expected?


--
Richard A. Smith                         Bitworks, Inc.               
rsmith@bitworks.com               501.846.5777                        
Sr. Design Engineer        http://www.bitworks.com   




