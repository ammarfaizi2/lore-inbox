Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: (majordomo@vger.rutgers.edu) by vger.rutgers.edu via listexpand id <S160093AbQGaQl5>; Mon, 31 Jul 2000 12:41:57 -0400
Received: by vger.rutgers.edu id <S157675AbQGaQjz>; Mon, 31 Jul 2000 12:39:55 -0400
Received: from mailout06.sul.t-online.com ([194.25.134.19]:1493 "EHLO mailout06.sul.t-online.com") by vger.rutgers.edu with ESMTP id <S160749AbQGaQSD>; Mon, 31 Jul 2000 12:18:03 -0400
Date: 31 Jul 2000 16:57:00 +0200
From: kaih@khms.westfalen.de (Kai Henningsen)
To: linux-kernel@vger.rutgers.edu
Message-ID: <7iw6kYsXw-B@khms.westfalen.de>
In-Reply-To: <200007271531.KAA89926@tomcat.admin.navo.hpc.mil>
Subject: Re: RLIM_INFINITY inconsistency between archs
X-Mailer: CrossPoint v3.12d.kh5 R/C435
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Organization: Organisation? Me?! Are you kidding?
References: <200007271459.KAA04701@tsx-prime.MIT.EDU> <200007271531.KAA89926@tomcat.admin.navo.hpc.mil>
X-No-Junk-Mail: I do not want to get *any* junk mail.
Comment: Unsolicited commercial mail will incur an US$100 handling fee per received mail.
X-Fix-Your-Modem: +++ATS2=255&WO1
Sender: owner-linux-kernel@vger.rutgers.edu

pollard@tomcat.admin.navo.hpc.mil (Jesse Pollard)  wrote on 27.07.00 in <200007271531.KAA89926@tomcat.admin.navo.hpc.mil>:

> Might I suggest creating a "/lib/include" that works something like
> the /lib/modules where the kernel name is used to generate the directory
> for the kernel include files?
>
> That way the "uname -r" command could be used to set a symbolic link
> to point to the correct include files at boot time (or install time).

Correct for what?

I think this is silly.

There are two versions of header files people tend to be interested in:

a. The ones corresponding to the libc version their linker will link  
against. This will be good for 99% of the situations.

b. A special version for some kernel-version-dependant executable. Exact  
version depends on what they plan to do with that executable - could be  
most advanced kernel version available, least advanced version available,  
a specific version whose significance depends on the configuration of a  
different machine, whatever.

There is no reason to assume that the currently running kernel version is  
any more relevant than any of the other arguments for b.

> This way the kernel that is active would be selecting the correct includes.

Correct for what?


MfG Kai

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
