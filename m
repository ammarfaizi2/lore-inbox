Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292085AbSBOKfj>; Fri, 15 Feb 2002 05:35:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292087AbSBOKfb>; Fri, 15 Feb 2002 05:35:31 -0500
Received: from gemini.rz.uni-ulm.de ([134.60.246.16]:65527 "EHLO
	mail.rz.uni-ulm.de") by vger.kernel.org with ESMTP
	id <S292085AbSBOKfY>; Fri, 15 Feb 2002 05:35:24 -0500
Date: Fri, 15 Feb 2002 11:35:19 +0100 (MET)
From: Markus Schaber <markus.schaber@student.uni-ulm.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Opses
In-Reply-To: <20020214143358.301201f9.markus.schaber@student.uni-ulm.de>
Message-ID: <Pine.SOL.4.44.0202151123260.12133-101000@lyra.rz.uni-ulm.de>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-559023410-1804928587-1013769319=:12133"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---559023410-1804928587-1013769319=:12133
Content-Type: TEXT/PLAIN; charset=US-ASCII

Hello,

On Thu, 14 Feb 2002, Markus Schaber wrote:

> It happened using 2.4.14, 2.4.27 and one or two 2.4 versions I don't
> remember now.

Sorry, it should read 2.4.17, not 2.4.17 :-(

Some of you asked for additional information, so here it is:

I don't remember which older kernels also produced this behaviour, but it
is very likely that 2.4.10 is one of them.

The machine is used as an internet server, running apache, zope, php,
postgresql, ftp-proxy and nfc-chat. It also runs a tivoli storage manager
client (dsmc) to take part in the university backup system, and has a
local X server and sshd for maintainance purpses. There are some other
standard daemons (ntp, cron etc.) running, but the machine does no routing
/ firewalling etc.

cpuinfo tells the following: (Yes, I know it is no good to run a server on
a Duron, but this decision was not mine.)

processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 3
model name      : AMD Duron(tm) Processor
stepping        : 1
cpu MHz         : 700.054
cache size      : 64 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov
pat pse36 mmx fxsr syscall mmxext 3dnowext 3dnow
bogomips        : 1395.91


I also attached a .bzip2'ed variant of my 2.4.17 .config file.


[I'll be away 'till monday. I have access to the machine and my mail via
ISDN dialin over the weekend, but have to pay time-based.]

Thank you,
Markus Schaber

---559023410-1804928587-1013769319=:12133
Content-Type: APPLICATION/octet-stream; name="config2417.bz2"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.SOL.4.44.0202151135190.12133@lyra.rz.uni-ulm.de>
Content-Description: bzip2 compressed .config
Content-Disposition: attachment; filename="config2417.bz2"

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
UtH/i7kinChIVjoB64A=
---559023410-1804928587-1013769319=:12133--
