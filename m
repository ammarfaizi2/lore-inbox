Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273406AbRIRTOZ>; Tue, 18 Sep 2001 15:14:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273413AbRIRTOQ>; Tue, 18 Sep 2001 15:14:16 -0400
Received: from line167.adsl.actcom.co.il ([192.117.101.167]:26885 "HELO
	alhambra.merseine.nu") by vger.kernel.org with SMTP
	id <S273406AbRIRTOF>; Tue, 18 Sep 2001 15:14:05 -0400
Date: Tue, 18 Sep 2001 22:11:02 +0300 (IDT)
From: mulix <mulix@actcom.co.il>
X-X-Sender: <mulix@alhambra.merseine.nu>
To: <linux-kernel@vger.kernel.org>
Cc: <choo@actcom.co.il>
Subject: ANN: syscalltrack version 0.60 released
Message-ID: <Pine.LNX.4.33.0109182157020.18755-100000@alhambra.merseine.nu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Haifux, the Haifa Linux Club (http://linuxclub.il.eu.org) is proud to
present 'syscalltrack-0.60', the first _alpha_ release of the
system-call-tracking linux kernel module and user space utilities.
'syscalltrack' supports both versions 2.2.x and 2.4.x of the linux
kernel.

* What is syscalltrack?

Imagine you have a file being deleted every day at midnight. How will
you know which process does it?

Imagine you wish to know when any non root process tries to open a file
for writing, but you dont care if it tries to open it for reading. How
will you do that?

Imagine you wish to know when _any_ process tries to temper with
/var/log/messages. How will you do it?

'syscalltrack' is a linux kernel module which allows you to hijack and
track any system call invocation on your linux box. Using a
configuration utility you can specify 'filters' based on both system
call parameters and process state parameters. You also specify 'actions'
to take if the the filter matches - for example, you can log the
invocation to a log file. More actions are planned but not yet
implemented.

For example, you might say "log all processes which try to 'unlink'
'/etc/passwd" or "log all processes which try to 'open' '/dev/dsp' with
a mode of O_CREAT, where the UID is less than 100 and the GID is more
than 1000".

We are aware of the existence of related projects, such as the 'medusa
DS9 security system'. We believe our approach is sufficiently different
to merit the apparent duplication of effort. In any event, the
'syscalltrack' has already proven to be both useful and educational.

* Where can i get it?

Information on 'syscalltrack' is available on the project's homepage:
http://syscalltrack.sf.net, and in the project's file release.

Files and development information are available from
http://www.sf.net/projects/syscalltrack/.

You can download the source directly from:
http://prdownloads.sourceforge.net/syscalltrack/syscalltrack-0.60.tar.gz

* Call for developers:

The syscalltrack project is looking for developers, both for kernel
space and user space. If you want to join in on the fun, get in touch
with us on the 'syscalltrack-hackers' mailing list
(http://lists.sourceforge.net/lists/listinfo/syscalltrack-hackers).

* License and NO Warrany

'syscalltrack' is Free Software, licensed under the GNU General Public
License (GPL) version 2. The 'sct_ctrl_lib' library is licensed under
the GNU Lesser General Public License (LGPL).

'syscalltrack' is in early _alpha_ stages and comes with NO warranty. If
it breaks something, you get to keep all of the pieces. You have been
warned (TM).

Happy hacking and tracking!

-- 
mulix

http://www.advogato.com/person/mulix
http://www.sf.net/projects/syscalltrack



