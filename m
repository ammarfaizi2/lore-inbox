Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284160AbRLTLL0>; Thu, 20 Dec 2001 06:11:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284153AbRLTLLR>; Thu, 20 Dec 2001 06:11:17 -0500
Received: from pat.uio.no ([129.240.130.16]:49568 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S284144AbRLTLLH>;
	Thu, 20 Dec 2001 06:11:07 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15393.51009.856041.463215@charged.uio.no>
Date: Thu, 20 Dec 2001 12:10:57 +0100
To: Steffen Persvold <sp@scali.no>
Cc: lkml <linux-kernel@vger.kernel.org>, nfs list <nfs@lists.sourceforge.net>,
        Neil Brown <neilb@cse.unsw.edu.au>
Subject: Re: 2.4.8 NFS Problems
In-Reply-To: <3C21B30D.871B6BE4@scali.no>
In-Reply-To: <3C21B30D.871B6BE4@scali.no>
X-Mailer: VM 6.92 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Steffen Persvold <sp@scali.no> writes:

    >> I've been getting random NFS EIO errors for a few months but
    >> now it's repeatable. Trying to copy a large file from one 2.4.8
    >> SMP box to another is consistently failing (at different
    >> offsets >each time).

Please try the patch on

  http://www.fys.uio.no/~trondmy/src/2.4.17/linux-2.4.17-fattr.dif

that fixes at least 1 such EIO error which was discovered using fsx.

Cheers,
   Trond
