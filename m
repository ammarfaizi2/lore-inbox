Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315690AbSHMPLc>; Tue, 13 Aug 2002 11:11:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317405AbSHMPLb>; Tue, 13 Aug 2002 11:11:31 -0400
Received: from pat.uio.no ([129.240.130.16]:33183 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S315690AbSHMPL3>;
	Tue, 13 Aug 2002 11:11:29 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15705.8826.187824.60331@charged.uio.no>
Date: Tue, 13 Aug 2002 17:15:06 +0200
To: Helge Hafting <helgehaf@aitel.hist.no>
Cc: neilb@cse.unsw.edu.au, trond.myklebust@fys.uio.no, vojtech@suse.cz,
       linux-kernel@vger.kernel.org
Subject: Various trouble in 2.5.31
In-Reply-To: <3D58F932.4D87A904@aitel.hist.no>
References: <3D58F932.4D87A904@aitel.hist.no>
X-Mailer: VM 7.00 under 21.4 (patch 6) "Common Lisp" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Helge Hafting <helgehaf@aitel.hist.no> writes:

     > Some problems and oddities I have seen: UP, no preempt
     > * nfs gets stuck sometimes.  klogd and rpciod shares the cpu,
     >   umounting is impossible.  cat'ing a nfs file shows the
     >   contents but the cat process won't die.  Stuck on close?
     >   This also happens with 2.5.30

Could you get me a log from tcpdump and 'echo 1 >/proc/sys/sunrpc/rpc_debug'
when this happens?

Cheers,
  Trond
