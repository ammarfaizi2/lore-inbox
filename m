Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262607AbTCRXfz>; Tue, 18 Mar 2003 18:35:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262608AbTCRXfz>; Tue, 18 Mar 2003 18:35:55 -0500
Received: from mx0.gmx.de ([213.165.64.100]:18398 "HELO mx0.gmx.net")
	by vger.kernel.org with SMTP id <S262607AbTCRXfx>;
	Tue, 18 Mar 2003 18:35:53 -0500
Date: Wed, 19 Mar 2003 00:46:47 +0100 (MET)
From: micklweiss@gmx.net
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Subject: Linux on 16-bit processors
X-Priority: 3 (Normal)
X-Authenticated-Sender: #0014467546@gmx.net
X-Authenticated-IP: [205.188.209.70]
Message-ID: <17232.1048031207@www59.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm interested on running Linux on some less powerful, cheaper 16 bit
systems. I would like to know if there is a slimmed down version of the kernel (any
version 2.2+) that can run on 16-bit CPUs. I know that linux "requires" a
32-bit CPU, but I know that it has run on less. I'm interested in any arch -
really. 
I can't seem to find a slimmed down version of the kernel. Any projects out
there? Something with decent performance would be cool too. :o)

I'm not apart of the list, so if you could pleace CC: any replies to this
e-mail (micklweiss@gmx.net) that would be great.

I asked before at a local user group (southflorida embedded user group)..
and this is what info they got me. I just cut-n-pasted.

<cut>

To: Mick Weiss
From: "wblake@emsys.net" <wblake@emsys.net>

glad to help. you have interesting research.
Most handhelds these days are 32 bit processors, even pagers. Mostly some
ARM variant especially Intel StrongArm.

The main obstacle to running Linux on smaller (cheaper) CPUs seems to be an
MMU which Linux and most Unixes expect. For a Linux work alike, some RTOS's
will have various POSIX layers corresponding to  standard C library,
real-time facilities, threads, and shell utilities. So if an application
uses POSIX compliant calls, it can move from *ix to one of these operating
systems.
Most *Ix work alikes Lynx, and QNX claim POSIX compliance. Likewise
embedded RTOSes like Red Hat eCos, rtxc, mentor ati nucleus, vrtx, vxworks
etc. 
Even Microsoft supports many of these POSIX interfaces as do other non Unix
OS's like Digital (now HP) VMS, IBM MVS, IBM VM etc 

http://www.embedded.com/story/OEG20010312S0073

Original Message:
-----------------
From:  micklweiss@gmx.net
Date: Tue, 18 Mar 2003 14:39:45 +0100 (MET)
To: emsys@emsys.net
Subject: 


Lineo supports processors in the following specific architectures: 

32 bit with memory management 
32 bit without memory management 
16 bit/ 16 bit DSP 
8 bit processor/ 8 bit controller 

and uclinux is a whopping $200 (its whopping when your just messing with it
on your spare time ;), plus I'm not sure how its licenced (GPL?).

----

after searching I found a few things on RTLinux and linux on handhelds, but
-- oh well I'll keep looking (its only for myself, no business reasons, so
its not important)

miniRTL (after porting it) may be a good design to work from, I'll just have
to see.

Thanks Wil for all the info, It definitly sounds cool. I am looking into it
right now.

See you at the next meeting,

- Mick

-- 
(o> Web developer / designer
( )     UNIX Systems Admin
---   ~ www.mickweiss.com ~

</cut>

Thanks in advance for any help,

- Mick

(o> Web developer / designer
( )     UNIX Systems Admin
---   ~ www.mickweiss.com ~

-- 
+++ GMX - Mail, Messaging & more  http://www.gmx.net +++
Bitte lächeln! Fotogalerie online mit GMX ohne eigene Homepage!

