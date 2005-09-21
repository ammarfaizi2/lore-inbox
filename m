Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750921AbVIUNoa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750921AbVIUNoa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 09:44:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750923AbVIUNoa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 09:44:30 -0400
Received: from Lodur.telex.com ([192.112.63.16]:45062 "EHLO lodur.telex.com")
	by vger.kernel.org with ESMTP id S1750919AbVIUNo3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 09:44:29 -0400
In-Reply-To: <200509211627.12154.vda@ilport.com.ua>
To: Denis Vlasenko <vda@ilport.com.ua>
Cc: linux-kernel@vger.kernel.org
Subject: Bogomips on AMD X2 (was Re:)
MIME-Version: 1.0
X-Mailer: Lotus Notes Release 6.5.1 January 21, 2004
From: Robert.Boermans@uk.telex.com
Message-ID: <OF73453AE5.CDE706CC-ON80257083.004ACF55-80257083.004B7A0F@telex.com>
Date: Wed, 21 Sep 2005 14:44:28 +0100
X-MIMETrack: Serialize by Router on Passthru01/Telex(652HF636|November 23, 2004) at 09/21/2005
 08:44:29 AM,
	Serialize complete at 09/21/2005 08:44:29 AM
Content-Type: text/plain; charset="US-ASCII"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Denis Vlasenko <vda@ilport.com.ua> 
21/09/2005 14:27

To
Robert.Boermans@uk.telex.com
cc
linux-kernel@vger.kernel.org
Subject
Re:






On Wednesday 21 September 2005 16:20, Robert.Boermans@uk.telex.com wrote:
> Hello, 
> 
> I noticed that the bogomips results for the two cores on my machine are 
> consistently not the same, the second one is always reported slightly 
> faster, it's a small difference and I saw the same in a posted dmesg 
from 
> somebody else on the list. Which made me wonder: 

I guess it's a cache warming effect. Please show the numbers.
--
vda

Probably not, got this one from a web site, and on this one the first core 
seems to be faster (can't check my own machine it's off and at home and 
I'm at work.) The difference I get is similar, but always with the second 
one faster. It's the same when using cat on /proc/cpuinfo. Oh and I saw it 
on 2.6.11 and 2.6.12 as supplied with fedora core 4 myself.

Calibrating delay using timer specific routine.. 4014.73 BogoMIPS 
(lpj=8029470)
Mount-cache hash table entries: 512
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 512K (64 bytes/line)
CPU 0(2) -> Core 0
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
mtrr: v2.0 (20020519)
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
CPU0: AMD Athlon(tm) 64 X2 Dual Core Processor 3800+ stepping 02
Booting processor 1/1 eip 2000
Initializing CPU#1
Calibrating delay using timer specific routine.. 4005.37 BogoMIPS 
(lpj=8010751)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 512K (64 bytes/line)
CPU 1(2) -> Core 1
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#1.
CPU1: AMD Athlon(tm) 64 X2 Dual Core Processor 3800+ stepping 02
Total of 2 processors activated (8020.11 BogoMIPS).
