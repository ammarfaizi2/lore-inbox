Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262861AbTEGFJy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 01:09:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262863AbTEGFJy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 01:09:54 -0400
Received: from [195.95.38.160] ([195.95.38.160]:15352 "HELO mail.vt4.net")
	by vger.kernel.org with SMTP id S262861AbTEGFJw convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 01:09:52 -0400
From: DevilKin <devilkin-lkml@blindguardian.org>
To: Pavel Machek <pavel@suse.cz>, linux-kernel@vger.kernel.org,
       Devilkin-lkml@blindguardian.org
Subject: Re: [Bug 582] New: network device does not survive laptop suspend
Date: Wed, 7 May 2003 07:23:02 +0200
User-Agent: KMail/1.5.1
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200305070723.07767.devilkin-lkml@blindguardian.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

> Hi! 
>> http://bugme.osdl.org/show_bug.cgi?id=582 
>>  
>>            Summary: network device does not survive laptop suspend 
>>     Kernel Version: 2.5.66 
>>             Status: NEW 
>>           Severity: high 
>>              Owner: apmbugs@rothwell.emu.id.au 
>>          Submitter: devilkin@gmx.net 
>>  
>>  
>> Distribution: Debian Unstable 
>> Hardware Environment: Dell Latitude CPxJ 650 
>> Software Environment: ? 
>> Problem Description:  
>>  
>> I suspended my laptop this morning to move it from home to work without 
>> having to shhutdown everything. The laptop came nicely out of the suspend, 
>> except for my Cardbus ethernet device. 
>>  
>> Since i resumed the laptop it hangs around every 10 seconds for around 2 
>> seconds. Everything hangs, from mouse movement, to audio playback, to 
>> pinging. This is seen in syslog, in great numbers: 
>> eth0: Transmitter encountered 16 collisions -- network cable problem? 
>> eth0: Interrupt posted but not delivered -- IRQ blocked by another device? 
>>   Flags; bus-master 1, dirty 0(0) current 16(0) 
>>   Transmit list ffffffff vs. ce6da200. 
>> eth0: command 0x3002 did not complete! Status=0xffff 

> ACPI or APM sleep? suspend-to-RAM or disk? I see apmbugs as a owner... 
> Anyway it is up to someone with affected ethernet card to fix it... 

APM sleep.

Jan
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+uJg4puyeqyCEh60RAhFKAJ9/rbZf2ikRgZvNWa6XZSoEgLzQOQCfUklH
u/IpL3JxI6F4gxzhAnD/tKE=
=uRFB
-----END PGP SIGNATURE-----

