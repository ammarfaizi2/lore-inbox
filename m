Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263491AbSJSLGN>; Sat, 19 Oct 2002 07:06:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264614AbSJSLGN>; Sat, 19 Oct 2002 07:06:13 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:33552 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S263491AbSJSLGM>;
	Sat, 19 Oct 2002 07:06:12 -0400
Date: Sat, 19 Oct 2002 07:12:15 -0400 (EDT)
Message-Id: <200210191112.g9JBCFl288460@saturn.cs.uml.edu>
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
To: linux-kernel@vger.kernel.org
Subject: [ANNOUNCE] procps 3.0.4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


That was rather new code last time... the new top now runs much
better, so you don't have to give up Linux 2.2.xx to support the
2.5.xx kernel, etc.

The WOLK kernel needs a patch -- or rather, one less patch. :-)
The procps-2.x.x code silently gives bad output; it does NOT work.

http://procps.sf.net/
http://procps.sf.net/procps-3.0.4.tar.gz

------------ changes ------------

procps-3.0.3 --> procps-3.0.4

make top go faster
Linux 2.2.xx ELF note warning removed
only show IO-wait on recent kernels
fix top's SMP stats
fix top for "dumb" and "vt510" terminals
in top, limit the priority values to -99 ... 99

procps-3.0.2 --> procps-3.0.3

more "make install" fixes
lib CFLAGS working again
top.1 codes fixed
bad (int*) cast in top removed
top runs faster
libproc memory corruption fixed
rant moved out of top.1 man page
ability to SKIP installing things
fixed ps --sort crash

procps-3.0.1 --> procps-3.0.2

top defaults to the old layout
top defaults to sorting by %CPU
fix top for non-SMP 2.2.xx and 2.0.xx
new "make install" fixed
vmstat -a fixed
vmstat compiles with latest gcc-3.x
vmstat does 64-bit time
