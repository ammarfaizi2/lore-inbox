Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285207AbRLMV5C>; Thu, 13 Dec 2001 16:57:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285209AbRLMV4x>; Thu, 13 Dec 2001 16:56:53 -0500
Received: from mail.ccur.com ([208.248.32.212]:34319 "EHLO mail.ccur.com")
	by vger.kernel.org with ESMTP id <S285207AbRLMV4d>;
	Thu, 13 Dec 2001 16:56:33 -0500
Subject: [RFC] Multiprocessor Control Interfaces (update)
From: Jason Baietto <jason.baietto@ccur.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0 (Preview Release)
Date: 13 Dec 2001 16:56:21 -0500
Message-Id: <1008280587.5764.4.camel@tofu>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A new version of my proposed multiprocessor control interfaces
is available here:

   http://www.ccur.com/realtime/oss

This version has some fixes and documentation updates and
incorporates some of the recent suggestions that I've received.
Here's the latest help output from run:

Usage: run [OPTIONS] { COMMAND [ARGS] | PROCESS_SPECIFIER }
Set scheduling parameters and CPU bias for a new process or a list
of existing processes.

OPTIONS can be one or more of the following options:

   -b, --bias=LIST        Set the CPU bias to the LIST of CPUs;
                          CPUs are numbered starting from 0
   -s, --policy=POLICY    Set the scheduling policy to POLICY
   -P, --priority=LEVEL   Set the scheduling priority to LEVEL
   -q, --quantum=QUANTUM  Set the SCHED_RR quantum to QUANTUM
   -N, --negate           Negate the CPU bias list; all CPUs
                          except those listed will be selected
   -f, --fork             Fork COMMAND and return immediately
   -V, --version          Output version information and exit
   -v, --verbose          Output information before each action
   -h, --help             Display this help and exit

PROCESS_SPECIFIER is exactly one of the following options:

   -p, --pid=LIST         Specify LIST of existing PIDs to modify
   -g, --group=LIST       Specify LIST of process groups to modify; all
                          existing processes in the groups will be modified
   -u, --user=LIST        Specify LIST of users to modify; all existing
                          processes owned by the users will be modified
   -n, --name=LIST        Specify LIST of existing process names to modify

Multiple comma separated values can be specified for all LISTs and ranges
are allowed where appropriate (e.g. "run -b 0,2-5 autopilot").

See the run(1) man page for more information.

Take care,
Jason
--
Jason Baietto
jason.baietto@ccur.com



