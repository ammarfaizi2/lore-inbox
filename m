Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310241AbSCaA7z>; Sat, 30 Mar 2002 19:59:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310501AbSCaA7p>; Sat, 30 Mar 2002 19:59:45 -0500
Received: from web20809.mail.yahoo.com ([216.136.226.198]:22537 "HELO
	web20809.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S310241AbSCaA7d>; Sat, 30 Mar 2002 19:59:33 -0500
Message-ID: <20020331005932.50830.qmail@web20809.mail.yahoo.com>
Date: Sat, 30 Mar 2002 16:59:32 -0800 (PST)
From: George Kola <procproj@yahoo.com>
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We are working on a project to implement Solaris-sytle
process control in Linux /proc.  Previous disscussions
have suggested such process control is desirable, but
we could not find any actual implementation.

The primary features we are implementing are the
following:

* Transparent control: Attaching to a process will not
change behavior of the process until directed.  Unlike
ptrace, we will not munge the parent pointer in a
process.

* Selective tracing of signals and syscalls.

* Multiple attaching processes.  Multiple cooperating
tracing programs can attach to a single process.

          These features have been long felt need of
the paradyn project (www.cs.wisc.edu/paradyn). We want
the feedback of the community on this work.

-George             



__________________________________________________
Do You Yahoo!?
Yahoo! Greetings - send holiday greetings for Easter, Passover
http://greetings.yahoo.com/
