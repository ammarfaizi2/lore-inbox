Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261490AbRFDXve>; Mon, 4 Jun 2001 19:51:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263028AbRFDXvY>; Mon, 4 Jun 2001 19:51:24 -0400
Received: from p114.nas1.is5.u-net.net ([195.102.200.114]:5361 "EHLO
	keston.u-net.com") by vger.kernel.org with ESMTP id <S261490AbRFDXvW>;
	Mon, 4 Jun 2001 19:51:22 -0400
Message-ID: <003401c0ed51$3347a0c0$1901a8c0@node0.idium.eu.org>
From: "David Flynn" <Dave@keston.u-net.com>
To: "linux kernel mailinglist" <linux-kernel@vger.kernel.org>
Subject: Oh Bother
Date: Tue, 5 Jun 2001 00:50:57 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
X-MDRemoteIP: 192.168.1.25
X-Return-Path: Dave@keston.u-net.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Morning Guys, (or whatever time you call this ungodly hour)
        A couple of things to bring up:

1) I was just rebuilding gcc (for an i586 on my faster PII) everything was
going fine and suddenly silence, all my ssh sessions have locked up, the
serial console is dead, the system is not responding to ping's on any of its
interfaces and when connecting a monitor / keyboard up, they are dead too
.... the monitor is in "blank mode" (HaHa -- the most irritating thing i
find with linux) mode.  My conclusion: the system has completely died / hung
with no warning of anykind (any panic issued would not be noticed as the
damn monitor has been put in blank mode by the system).

Anyone got any suggestions (more so with point 2) ?

2) How do you stop the stupid system blanking / power saving the monitor
???? sure, it can be done with a setterm command, but, i dont use the
monitor for a terminal, the box is remote access only... its only for
looking at error messages that apear at the console

3) upon looking at the log files, where nothing about todays incident is
mentioned, but i did notice some from a previous day :

Jun  2 21:38:52 kernel: TCP: peer 216.41.36.109:80/2882 shrinks window
1109891031:1:1109891568. Bad, what else can I say?
Jun  2 21:38:53 kernel: TCP: peer 216.41.36.109:80/2882 shrinks window
1109891032:1:1109891568. Bad, what else can I say?
Jun  2 21:38:58 kernel: NET: 1 messages suppressed.
Jun  2 21:38:58 kernel: TCP: peer 216.41.36.109:80/2882 shrinks window
1109891034:1:1109891568. Bad, what else can I say?
Jun  2 21:39:03 kernel: TCP: peer 216.41.36.109:80/2880 shrinks window
1068438541:1:1068439073. Bad, what else can I say?
Jun  2 21:39:13 kernel: NET: 2 messages suppressed.
Jun  2 21:39:13 kernel: TCP: peer 216.41.36.109:80/2876 shrinks window
1066801908:1:1066802376. Bad, what else can I say?
Jun  2 21:39:17 kernel: TCP: peer 216.41.36.109:80/2882 shrinks window
1109891036:1:1109891568. Bad, what else can I say?
Jun  2 21:39:44 kernel: TCP: peer 216.41.36.109:80/2882 shrinks window
1109891037:1:1109891568. Bad, what else can I say?
Jun  2 21:40:58 kernel: TCP: peer 216.41.36.109:80/2906 shrinks window
1257011113:1:1257011569. Bad, what else can I say?
Jun  2 21:40:58 kernel: TCP: peer 216.41.36.109:80/2907 shrinks window
1250316486:1:1250316939. Bad, what else can I say?

what on earth is all that about ?

the systems running 2.4.5 on a PII


Anyway, i had better get back to sorting out this box, it seems the crash
has done some nast stuff to the file system ... it seems that part of gcc is
now crosslinked with a hell of alot of other files, i can only hope that all
the devel and research work on that box is unharmed!

Thanks,

Dave

---------------------------------------
The information in this e-mail and any files sent with it is confidential to
the ordinary user of the e-mail address to which it was addressed and may
also be legally privileged. It is not to be relied upon by any person other
than the addressee except with the sender's prior written approval. If no
such approval is given, the sender will not accept liability (in negligence
or otherwise) arising from any third party acting, or refraining from
acting, on such information. If you are not the intended recipient of this
e-mail you may not copy, forward, disclose or otherwise use it or any part
of it in any form whatsoever. If you have received this e-mail in error
please notify the sender immediately, destroy any copies and delete it from
your computer system. Have a nice Day !
---------------------------------------------


