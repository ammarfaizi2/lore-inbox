Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263191AbTDLJ1x (for <rfc822;willy@w.ods.org>); Sat, 12 Apr 2003 05:27:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263214AbTDLJ1w (for <rfc822;linux-kernel-outgoing>);
	Sat, 12 Apr 2003 05:27:52 -0400
Received: from pat.uio.no ([129.240.130.16]:28336 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S263191AbTDLJ1w (for <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Apr 2003 05:27:52 -0400
To: Greg Wooledge <greg@wooledge.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: NFS client hangs when X is running (2.4.20)
References: <20030411233132.GA15999@pegasus.wooledge.org>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 12 Apr 2003 11:39:25 +0200
In-Reply-To: <20030411233132.GA15999@pegasus.wooledge.org>
Message-ID: <shsfzoodpgy.fsf@charged.uio.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Honest Recruiter)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Greg Wooledge <greg@wooledge.org> writes:


Sounds very much like a network card driver problem.

     > [5.] nfs: server pegasus not responding, still trying However,
     > this is erroneous.  Pegasus (the OpenBSD box) responds
     > perfectly to ping, showmount -e, ssh and so on.  Any existing
     > ssh connections to pegasus continue working, even ones I
     > started in an rxvt window in the 15-30 second period when the
     > NFS subsystem hadn't locked up yet.  No other errors are
     > reported.

.... and a tcpdump would show?

Cheers,
  Trond
