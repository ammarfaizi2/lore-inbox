Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271256AbTGQUwF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 16:52:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271289AbTGQUwF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 16:52:05 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:59396 "HELO
	kinesis.swishmail.com") by vger.kernel.org with SMTP
	id S271256AbTGQUwC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 16:52:02 -0400
Message-ID: <3F1711B5.9020800@techsource.com>
Date: Thu, 17 Jul 2003 17:14:29 -0400
From: Timothy Miller <miller@techsource.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [OT??] HELP:  Getting lousy memory throughput from Abit KD7
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I recently bought an Abit KD7, and I'm having a few problems with it.  I
hope someone can please help me with them.

According to the BIOS screen, the board model I have is
KT400-8235-6A6LYA1AC-DN.  I have an Athlon XP 2800+ (barton core,
333mhz fsb) with 1 GIG of PC2700 DDR.  The board has AwardBIOS.

I'm running Red Hat 9 with their latest kernel (something like 2.4.20-18).

The Corsair memory I'm using turns out to be from SpecTek, which uses
Micron silicon.  I called SpecTek to get a datasheet, and they
directed me to the data sheet for Micron MT46V64M4TG-6T.

I use the following settings for memory:

CAS latency: 2.5
Bank Interleave: 4
Trp: 3T
Tras: 7T
Trcd: 3T
Drive strength and controls are all Auto
DRAM Access: 3T
Enhance DRAM Performance: Disabled
DRAM Command Rate: 1T
Write Recovery Time: 3T
tWTR: 1T

The problem that I encounter is that I seem to be getting unusually low 
memory throughput. Using "memtest86", I get 665mb/sec. Using STREAM 
under Linux, I get closer to 1040 mb/sec peak. Doing some searches on 
google has revealed that most people get closer to their peak bandwidth, 
so, I should be expecting at least 2400 from STREAM, judging from the 
numbers others are getting. I know in the real world, you never get 
peak, but in synthetic tests, I should not be getting half the rated 
bandwidth.

I have already tried flashing the latest BIOS but the only result was 
that "Fast CPU command decode" option now causes the system to not POST 
(It didn't before).

If anyone could please help me to figure out what is slowing things
down, I would appreciate it very much.

I have a feeling this isn't a Linux-related issue, but you never know. 
Does STREAM report very low throughput compares to, say, SiSOFT SANDRA? 
  I haven't tried SANDRA because I don't want to install Windows.


Thank you.

