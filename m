Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261250AbULSN4u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261250AbULSN4u (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Dec 2004 08:56:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261291AbULSN4t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Dec 2004 08:56:49 -0500
Received: from out009pub.verizon.net ([206.46.170.131]:42632 "EHLO
	out009.verizon.net") by vger.kernel.org with ESMTP id S261250AbULSN4q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Dec 2004 08:56:46 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.10-rc3-mm1-V0.33-1
Date: Sun, 19 Dec 2004 08:56:45 -0500
User-Agent: KMail/1.7
References: <200412180708.17671.gene.heskett@verizon.net> <200412180748.37296.gene.heskett@verizon.net>
In-Reply-To: <200412180748.37296.gene.heskett@verizon.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200412190856.45497.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out009.verizon.net from [151.205.47.244] at Sun, 19 Dec 2004 07:56:45 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 18 December 2004 07:48, Gene Heskett wrote:
>On Saturday 18 December 2004 07:08, Gene Heskett wrote:
>>Greetings;
>>
>>I must report a couple of anomalies while running
>>2.6.10-rc3-mm1-V0.33-1
>
>CORRECTION!  2.6.10-rc3-mm1-V0.33-0, not 1!
>
And I am now officially confused.  These messages *are* coming back
from the server, but I am also getting delayed by a day, bounce
messages from the server?  Anybody have any idea whats fubared?

Also, in the FWIW dept, I'm back on 2.6.10-rc3,
realtime-preempt-2.6.10-rc3-mm1-V0.33-04 also went away in the middle
of an amanda run yesterday moring after an uptime of about 45
minutes, leaving no trail whatsoever in the messages log, and the
only possible clue was that the last runtapes session amanda ran,
with should have taken in the vacinity of 400 seconds, took only .389
seconds, but no error was logged in the amanda-dbg directory.  So I
have no clue.  The only consistent clue is that an lsof locks itself
till ctrl-c'd, and an amcheck run cannot wake the client on the
server, but connects with the client on the firewall box just fine.
And it works after a reboot.

>>Twice now, odd goings on, such as lsof just locks itself till you
>>give it a ctrl-c,  Only a reboot fixes this.
>>
>>And I assume its related, but NDI where, amanda's amandad gets
>> stuck and this machine was not backed up this morning.  The
>>/tmp/amanda-dbug/* files do not seem to offer any clues as to why,
>>other than an occasional timeout.  The other client machine on this
>>network, my firewall, was backed up normally, but nothing here made
>>it to tape.  This occured once before on a previous version, 32-19
>> I think but won't swear to, and I believe if I reboot right now,
>> and restart amdump, that it will work, so something would appear
>> to be uptime sensitive.
>>
>>kmail has repeatedly lost its connection to outgoing.verizon.net,
>> but a restart of kmail seems to restore that (if its not verizons
>> fault, they *were* playing with it earlier today).  But this has
>> been an ongoing problem.
>>
>>I'll go get the latest and install it for effects.

See above, 33-04 was also a no-show.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.30% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.

