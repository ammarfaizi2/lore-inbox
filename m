Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264416AbTEaUAs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 May 2003 16:00:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264429AbTEaUAs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 May 2003 16:00:48 -0400
Received: from smtp-out.comcast.net ([24.153.64.116]:31011 "EHLO
	smtp-out.comcast.net") by vger.kernel.org with ESMTP
	id S264416AbTEaUAp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 May 2003 16:00:45 -0400
Date: Sat, 31 May 2003 16:07:11 -0400
From: Albert Cahalan <albert@users.sf.net>
Subject: [ANNOUNCE] procps 3.1.9
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <1054411631.22103.725.camel@cube>
Organization: 
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.2.4
Content-type: text/plain
Content-transfer-encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This release fixes memory usage reporting when gcc 3.x
is used on IA-64 and Alpha. Other 64-bit platforms may
be affected. Documentation has improved a bit. Thanks to
Fabian Frederick, vmstat now lets you choose display units.
See the change log for details.

For those of you still upgrading from procps 2.0.xx releases,
you can expect:

* vmstat lets you choose units you like: 1000, 1024, 1000000...
* top can sort by any column (old sort keys available too)
* top can select a single user to display
* top can be put in multi-window mode and/or color mode
* vmstat has the -s option, as found on UNIX and BSD systems
* vmstat has the -f option, as found on UNIX and BSD systems
* watch doesn't eat the first blank line by mistake
* vmstat uses a fast O(1) algorithm on 2.5.xx kernels
* pmap command is SunOS-compatible
* vmstat shows IO-wait time
* pgrep and pkill can find the oldest matching process
* sysctl handles the Linux 2.5.xx VLAN interfaces
* top shows IO-wait time if-and-only-if your kernel computes it
* ps has a new "-F" format (very nice, like DYNIX/ptx has)
* ps with proper BSD process selection
* better handling of very long uptimes

There's a procps-feedback@lists.sf.net mailing list you can
use for feature requests, bug reports, and so on. Use it!
Feedback makes things happen.

http://procps.sf.net/
http://procps.sf.net/procps-3.1.9.tar.gz

------------- recent changes -------------

procps-3.1.8 --> procps-3.1.9

memory sizes fixed for 64-bit w/ gcc 3.x      #194376 #191933
ps: detect broken OS install w/o /proc mounted        #172735
top: fix suspend/resume behavior
top: ditch warning until a GOOD interface is found    #188271
kill: more info in the man page                       #182414
ps: document the -o, o, -O, and O options             #169301
vmstat: choose units you like: 1000, 1024, 1000000...

procps-3.1.7 --> procps-3.1.8

top: fix keyboard handling (help screen, etc.)

procps-3.1.6 --> procps-3.1.7

Makefile: made SKIP feature easier to use
watch: --help now explains -t, --no-title    #182246
ps: warning directs users to the FAQ
top: batch mode can refresh by fractional seconds
top: faster start-up
top: do not refresh like crazy
ps: better crash message

procps-3.1.5 --> procps-3.1.6

handle the 2.5.61 kernel
top: memory leak fixed
ps: new --ppid option selects by PPID
watch: new --no-title option             #179862
handle SPARC Linux badness
rare crash fixed
compile with gcc 2.91.xx again
more informative "ps --info"
README update
ps: compare more with "ps -C verylongname"     #178127

procps-3.1.4 --> procps-3.1.5

ancient (2.x.xx era) data corruption fixed
serious hidden-process problem (3.1.3+) fixed
w: escape sequence vulnerability fixed

procps-3.1.3 --> procps-3.1.4

top: was trashing every "3" in a command name
top: when killing a process, the PID was cut at a "3"
top: more reliable %CPU
update copyright dates (GPL & LGPL require this)
RPM generation works now


