Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264748AbTBAItH>; Sat, 1 Feb 2003 03:49:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264749AbTBAItH>; Sat, 1 Feb 2003 03:49:07 -0500
Received: from pat.uio.no ([129.240.130.16]:41166 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S264748AbTBAItG>;
	Sat, 1 Feb 2003 03:49:06 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15931.35891.22926.408963@charged.uio.no>
Date: Sat, 1 Feb 2003 09:58:27 +0100
To: David Ford <david+powerix@blue-labs.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: NFS problems, 2.5.5x
In-Reply-To: <3E3B2D2E.8000604@blue-labs.org>
References: <3E3B2D2E.8000604@blue-labs.org>
X-Mailer: VM 7.07 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == David Ford <david+powerix@blue-labs.org> writes:

     > Synopsis: nfsserver:/home/david mount, get dir. entries loops
     > forever,
     > 2.5.59 for client and server.

     > Example: ls -l /home/david

     > An strace will show the same directory entries flying by over
     > and over until memory is exhausted or ^c comes along.  It
     > worked at first for about 30 minutes while I finished the new
     > gentoo install on my desktop, but then things got weird.  the
     > nfs server spat out a big long callback trace (oops) and died
     > hard.  Had to reset the power.  The looping started just
     > minutes before that.  I've rebooted, tried 2.5.53 on the client
     > but no go.

AFAICR, there have been no changes to the NFS client readdir code since
2.5.30.

Cheers,
  Trond
