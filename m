Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317429AbSGRLue>; Thu, 18 Jul 2002 07:50:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318003AbSGRLue>; Thu, 18 Jul 2002 07:50:34 -0400
Received: from pat.uio.no ([129.240.130.16]:23217 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S317429AbSGRLud>;
	Thu, 18 Jul 2002 07:50:33 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15670.44078.141083.237541@charged.uio.no>
Date: Thu, 18 Jul 2002 13:53:18 +0200
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: NFS can't get request (2.5.26)
In-Reply-To: <Pine.LNX.4.44.0207181207230.29012-100000@linux-box.realnet.co.sz>
References: <Pine.LNX.4.44.0207181207230.29012-100000@linux-box.realnet.co.sz>
X-Mailer: VM 7.00 under 21.4 (patch 6) "Common Lisp" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Zwane Mwaikambo <zwane@linuxpower.ca> writes:

     > Hi Trond, I got the following after trying to do tab completion
     > in an NFS fs, and straight afterwards on another console df(1).
     > the client finally recovered though.

     > nfs: task 626 can't get a request slot nfs: task 627 can't get
     > a request slot nfs: server montezuma OK nfs: server montezuma
     > OK

See the FAQ on nfs.sourceforge.net. The above error message indicates
congestion: either due to slow response from the server or due to some
networking issue.

You don't mention which kernel. Was it with the new RPC code in 2.5.26?

Cheers,
  Trond
