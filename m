Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264129AbTEXTxb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 May 2003 15:53:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264130AbTEXTxa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 May 2003 15:53:30 -0400
Received: from main.gmane.org ([80.91.224.249]:53930 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S264129AbTEXTx3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 May 2003 15:53:29 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Nicholas Wourms <nwourms@myrealbox.com>
Subject: Re: Aix7xxx unstable in 2.4.21-rc2? (RE: Linux 2.4.21-rc2)
Date: Sat, 24 May 2003 16:06:33 -0400
Message-ID: <3ECFD0C9.7020002@myrealbox.com>
References: <20030523085010$1ac2@gated-at.bofh.it> <20030523180021$109a@gated-at.bofh.it> <20030523203017$0e66@gated-at.bofh.it> <E19JXTg-0000HO-00@neptune.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@main.gmane.org
Cc: Willy Tarreau <willy@w.ods.org>
User-Agent: Mozilla/5.0 (Windows; U; Win 9x 4.90; en-US; rv:1.0.2) Gecko/20030208 Netscape/7.02
X-Accept-Language: en-us, en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pascal Schmidt wrote:
> On Fri, 23 May 2003 22:30:17 +0200, Willy Tarreau wrote in lkml:
> 
> 
>>By this time, there will be more and more people leaving vanilla kernel for
>>their machines, and using them only as a base to apply -aa, -ac, -jam, -wolk,
>>-** + sf.net/* + who_knows_what, and I find it a shame.
> 
> 
> I think you overestimate the number of aic7xxx users. It's not like
> 99% of all 2.4 users need the driver.
> 

I think you're smoking crack, I'd say that there are way more than 1% of 
the 2.4 users w/ an AIC-7XXX chipset based controller.  I don't know how 
things are like in Germany, but around here, Adaptec is usually thought 
to be the mainstream choice in SCSI solutions for professional 
workstations and low-to-mid range servers [I Am Not A Product Market 
Analyst, so this is just my personal opinion based on my experiences in 
the VAR/Retail sector...  YMMV].  Most of the popular OEM's offer some 
sort of SCSI option based on an AIC-7XXX series chipset for most of 
their non "home-use-only" lines.  I can't even count how many 
motherboard manufactures have embedded the AIC-7XXX series chip into 
their motherboard to provide integrated SCSI solutions.  Moreover, most 
of what Adaptec produces in their current core SCSI brand line 
(excepting DPT, etc) is based on some version of the AIC-7XXX chip.  I 
can damn well say for sure there are more AIC-7XXX users then there are 
Fusion users and, as was pointed out, that code has gone through much 
more invasive changes to bring it up to speed.

I think the bottom line is that those of us in Adaptec-userland would 
very much appreciate a *working*, current driver in the next kernel 
release.  AFAICT, the old code base that was reverted to still has some 
annoying "quirks", and frankly doesn't perform as well as the current 
driver [at least for me].  So, invasive or not, I think we ought to be 
"testing the code" of a driver release written by a person who is well 
qualified to know the ins and outs of the hardware he is writing the 
code for.  Obviously Justin has access to a multitude of Adaptec 
hardware and I am quite satisfied that he has sufficiently tested his 
modifications to the driver.  Waiting until 2.4.22, let alone 2.4.21, is 
actually released just seems too far down the road to be sane.

Just my $0.02 on this...

Cheers,
Nicholas


