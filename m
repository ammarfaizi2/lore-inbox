Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <S157585AbPJZUH5>; Tue, 26 Oct 1999 16:07:57 -0400
Received: by vger.rutgers.edu id <S157111AbPJZTsF>; Tue, 26 Oct 1999 15:48:05 -0400
Received: from tomcat.admin.navo.hpc.mil ([204.222.179.33]:3580 "EHLO tomcat.admin.navo.hpc.mil") by vger.rutgers.edu with ESMTP id <S157594AbPJZT30>; Tue, 26 Oct 1999 15:29:26 -0400
Date: Tue, 26 Oct 1999 14:28:46 -0500 (CDT)
From: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Message-Id: <199910261928.OAA41544@tomcat.admin.navo.hpc.mil>
To: linux-kernel@vger.rutgers.edu
Subject: Re: Sealing the kernel 
X-Mailer: [XMailTool v3.1.2b]
Sender: owner-linux-kernel@vger.rutgers.edu

>From: Aaron Sethman <androsyn@atomic-city.dev.powerize.com>
>On Tue, 26 Oct 1999, Dimitris Margaritis wrote:
>> Yes, John forgot to mention that we're assuming boot from a read-only 
>> media such as a write-protected floppy or CD-ROM.  We also assume 
>> that the rc scripts, kernel, and all modules to be loaded at boot 
>> time (before of course the sealing module) also reside on that medium.
>> 
>> About your last point, yes, root can do a lot of nasty things, but by 
>> sealing the kernel at least they are constrained to what's available 
>> through kernel services.  That may help presumably by disabling a lot 
>> of stuff in the running kernel.
>Or even a better idea, compile the kernel without module support all
>together.  Just hope that you don't have any of those blasted Plug and
>Pray devices.

It would be better (in general) to remove root as a privileged user.
Try
	http://www.rsbac.de/rsbac/

for a possible implementation.
-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
