Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267381AbUG2A7J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267381AbUG2A7J (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 20:59:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267390AbUG2A7J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 20:59:09 -0400
Received: from out003pub.verizon.net ([206.46.170.103]:18622 "EHLO
	out003.verizon.net") by vger.kernel.org with ESMTP id S267381AbUG2A7F
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 20:59:05 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.8-rc2 crash(s)?
Date: Wed, 28 Jul 2004 20:59:03 -0400
User-Agent: KMail/1.6.82
References: <200407242156.40726.gene.heskett@verizon.net> <200407250037.51874.gene.heskett@verizon.net> <20040729001234.GK2334@holomorphy.com>
In-Reply-To: <20040729001234.GK2334@holomorphy.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200407282059.03524.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out003.verizon.net from [141.153.76.185] at Wed, 28 Jul 2004 19:59:04 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 28 July 2004 20:12, William Lee Irwin III wrote:
>On Sun, Jul 25, 2004 at 12:37:51AM -0400, Gene Heskett wrote:
>> Update, it looks as if this new mobo is a bit much for the 350
>> watt supply in this case, the +5 volt line is wandering around a
>> couple of hundred millivolts, centered on about 4.86 volts.  IMO
>> thats not enough, particularly since its wandering around under
>> load. Would everyone agree?
>
>This is a somewhat intense audit of potential hardware-related
> issues. What behavior have you observed that has led you to believe
> there may be hardware problems affecting your situation?
>
This message is now a bit old, William. 

I was watching the psu voltages via gkrellm, and was seeing the 5 volt 
line go from 4.89, down to 4.73 in consecutive readings.  The new 420 
watt Antec, seems to be steadier at 4.87 +- 0.03 or so.

I suspect the tap point for the xx83627 chips input may not be right 
at the psu connector on the mobo cause I suspect the supply itself is 
probably doing 5.05 or so, although I haven't dropped my DVM on the 
line to test, its rather buried behind the drive cage.  But lemme go 
hit a drive power connector since there are spares on this psu, brb.  

Yeah, at a drive cables middle connector, with a small load on the 
end, its sitting at 5.00 volts, solid as a rock.  This supply has 
seperate regulators for the 5 volt, and 3.3 volt lines where the 
older one regulated everything against the 5 volt by turns ratios on 
the transformer, and was only a 300 watter, with 2 hd's, 2 floppy's 
and a dvd writer in addition to the motherboard load.

Anything else a C.E.T. can get for you?

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.24% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
