Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286303AbRLVAy2>; Fri, 21 Dec 2001 19:54:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286428AbRLVAyV>; Fri, 21 Dec 2001 19:54:21 -0500
Received: from tourian.nerim.net ([62.4.16.79]:65293 "HELO tourian.nerim.net")
	by vger.kernel.org with SMTP id <S286303AbRLVAyK>;
	Fri, 21 Dec 2001 19:54:10 -0500
Message-ID: <3C23D9B0.3010109@free.fr>
Date: Sat, 22 Dec 2001 01:54:08 +0100
From: Lionel Bouton <Lionel.Bouton@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6+) Gecko/20011214
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [BUG] 2.4.17-rc1, IDE : SIS735/SIS5513 unusable ?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Short :

SIS735 IDE subsystem unreliable -> system unusable.

Long :

I recently purchased an ECS K7S5AL mb built around the SIS735 chipset. 
The system built around this mb worked perfectly for one week before 
failing to boot with root fs mount errors. Subsequent tries to reinstall 
  the OS failed : either during the RedHat 7.2 install (fs error) or on 
the first boot after install (root fs mount error).

I trust all other components of the system (except the RAM and PSU which 
I purchased recently too) as they were heavily used in a previous one 
without a glitch.

I saw one other bugreport on lklm from one person with several SIS735 
mbs all failing on IDE DMA transfers and hints in the following thread 
that the init code for the SIS5513 is not complete for the SIS735 and 
might lead to the kind of problem I encountered (stable operation for a 
while followed by an unusable IDE subsystem).

I'm now on the way of heavy testing (Clean install on a drive in a 
separate system, master of the drive, move in the not-so-cooperative mb 
and several iterations of test-screwup-master_recopy-test-... ). I'll 
test different BIOS revisions, ide kernel parameters while searching for 
the SIS735 technical specs and then attempts at kernel hacking.

I noticed Andre by private mail and posted a bugreport on sis support 
web site asking them to supply appropriate init code to him. Is there 
something else I can do (specific sis e-mail contacts for technical 
papers for example, preliminary patch to test) ?

Lionel

