Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315718AbSEZFko>; Sun, 26 May 2002 01:40:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315722AbSEZFkn>; Sun, 26 May 2002 01:40:43 -0400
Received: from relay02.valueweb.net ([216.219.253.236]:25359 "EHLO
	relay02.valueweb.net") by vger.kernel.org with ESMTP
	id <S315718AbSEZFkm>; Sun, 26 May 2002 01:40:42 -0400
Message-ID: <3CF074DF.F39E6F97@opersys.com>
Date: Sun, 26 May 2002 01:38:39 -0400
From: Karim Yaghmour <karim@opersys.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.16 i686)
X-Accept-Language: en, French/Canada, French/France, fr-FR, fr-CA
MIME-Version: 1.0
To: Andrew Morton <akpm@zip.com.au>
CC: yodaiken@fsmlabs.com, Linus Torvalds <torvalds@transmeta.com>,
        linux-kernel@vger.kernel.org
Subject: Re: patent on O_ATOMICLOOKUP - Warning actual technical content.
In-Reply-To: <Pine.LNX.4.44.0205251651460.4120-100000@home.transmeta.com> <Pine.LNX.4.44.0205251729490.4355-100000@home.transmeta.com> <20020525212832.A6479@hq.fsmlabs.com> <3CF05852.9AED3237@opersys.com> <3CF05DC5.AF02BAEE@zip.com.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andrew Morton wrote:
> Just write the list, please.  I'm sure Victor will answer carefully.

Ok, here we go again. Some of these questions are at the core of
many of the uncertainties I alluded to earlier. I've grouped my
questions in categories.

These questions aim at defining the scope of the patent:
1) If I implement a non-GPL real-time application (whether it be in
user-space or in kernel space) which runs on something other than RTLinux,
do I need to purchase an RTLinux patent license (or any form of license
from FSMLabs for that matter)?

(Don't make the assumption that I'm talking about just RTAI here. I'm talking
about a general rt application/task/process which runs on a RTLinux-like
entirely GPL microkernel. This includes RTAI, but can be something else.)

2) Say I use a modified RTLinux or RTAI or some other GPL RTLinux-like
microkernel beneath Linux. Are non-RT non-GPL user applications subject
to your patent? Are non-RT non-GPL modules?


These questions are aimed at understanding the status of the intellectual
property contributed to RTLinux:
3) Given Paolo Montegazza's contributions to RTLinux, why isn't his name
in any of the copyrights of any file?

4) (corrolary of 3) Has no one ever contributed to RTLinux?
a) If someone has, then why do the main header files not have any other name
than FSMLabs'?
b) If no one ever has, then why is there a list of 20 names in the CREDITS
file in RTLinux's source tree?

5) Are you selling the rtlinux fifo code in closed-source?

6) Does RTLinuxPro include any of the RTLinux work done by Woflgang Denk's Denx?


These questions are aimed at understanding the management of RTLinux:
7) Why isn't Michael Barbanov supervising the development of RTLinux anymore?
Also, why isn't his name on the patent in light of the following statement
in your article entitled "Cheap operating systems research and teaching with
Linux" presented in early '96 at the "Conference on Freely Redistributable
Software":
"The real-time operating system described in section 2.1 has been taken from
concept to a working system by Michael Barabanov and, in particular, the
design of the soft iret is due to him."?

8) Why have the following ports never been integrated in the RTLinux source
code?
a) SuperH: ftp://ftp.aandd.co.jp/pub/linuxsh/rtlinux/current/
b) StrongARM: http://www.imec.be/rtlinux/

9) What is the difference between RTLinuxGPL and RTLinuxPro (a features list
would be nice)? Are these part of the same project? What is the future of
the GPL RTLinux? I ask this because of your recent interview on LinuxDevices.com 
(http://www.linuxdevices.com/articles/AT2570821322.html)
where you state the following:
"The GPL/RTLinux work that we do loses money -- actually, we budget it
under "marketing"."

10) What rules do you apply for including outside contributions to RTLinux?
Are they allowed? If they are, then do contributors get royalties on the
closed-source versions of their code that you sell?


Finally, some questions to understand RTLinux's history:
11) Why isn't the Stodolksy paper about the software emulation of interrupts
mentionned in your patent even though Barbanov clearly recognizes it as the
pilar of the methods implemented in RTLinux?

12) Given that you said the following to Jerry Epplin in January 2000:
"The main purpose of the patent was defensive as I did not want to find
myself paying royalties to someone else to use my idea. But I have no
objections to collecting fees from people who want to do this on Windows."
(the full email is available here: http://lwn.net/2000/0210/a/vy-patent.html,
I would have provided the entry in the actual RTLinux mailing list archive,
but last I checked the entire month of January 2000 is missing.), why is your
main concern today to tax every person developing real-time solutions with
Linux? Also, if the main purpose of the patent was defensive, then why did
you file suit against Lineo last year? Isn't there a patent estoppel problem
here?

13) You filed the provisional patent application on the 23rd of December 1996.
Given the 1 year limitation about public disclosure, doesn't the following
posting dated October 13th 1995 mean that you should have filed the provisional
application prior to October 13th 1996?
----------------------------------------------------------------------
From: yodaiken@chelm.cs.nmt.edu (Victor Yodaiken)
Subject: Re: Real Time Linux
Date: 1995/10/13
Message-ID: <45kuji$1pq@chaos.aoc.nrao.edu>#1/1
references: <44tmh6$5h0@lyra.csx.cam.ac.uk>
organization: New Mexico Tech Computer Science Department
newsgroups: comp.os.linux.development.system


In article <44tmh6$5h0@lyra.csx.cam.ac.uk>,
Martin Beckett <mgb@mail.ast.cam.ac.uk> wrote:
>
>Can Linux be used as a real-time operating system ?

We are currently working on developing a RT-linux where Linux itself
runs as the lowest priority pre-emptable task under a
rt-very-micro-kernel.  


> I have a control application where the PC runs a camera with a frame rate of
> 1 KHz.  At the end of each frame it must respond to a status bit on an I/O 
> port and read the data.  
> But this must be done within about 100 microsec of the end of the frame.
>
> At the moment I run this under DOS with all the hardware interrupts turned off
> and use a tight loop to monitor the status bit.


So if your task ran every millisecond it would be happy? How much data
must it read?


We'll be looking for simple examples to test in the next few weeks.
----------------------------------------------------------------------

Thanks for your time Victor. Let me know if you need any clarifications
regarding any of those questions.

Best regards,

Karim

===================================================
                 Karim Yaghmour
               karim@opersys.com
      Embedded and Real-Time Linux Expert
===================================================
