Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262342AbTCRPU4>; Tue, 18 Mar 2003 10:20:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262442AbTCRPU4>; Tue, 18 Mar 2003 10:20:56 -0500
Received: from pat.uio.no ([129.240.130.16]:26622 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S262342AbTCRPU4>;
	Tue, 18 Mar 2003 10:20:56 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15991.15327.29584.246688@charged.uio.no>
Date: Tue, 18 Mar 2003 16:31:43 +0100
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Neil Brown <neilb@cse.unsw.edu.au>
Subject: kernel nfsd
In-Reply-To: <20030318155731.1f60a55a.skraw@ithnet.com>
References: <20030318155731.1f60a55a.skraw@ithnet.com>
X-Mailer: VM 7.07 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Stephan von Krawczynski <skraw@ithnet.com> writes:

     > Hello Trond, hello all, can you explain what this means:

     > kernel: nfsd-fh: found a name that I didn't expect: <filename>

     > Should something be done against it, or is it simply
     > informative?

The comment in the code just above the printk() reads

                /* Now that IS odd.  I wonder what it means... */

Looks like you and Neil (and possibly the ReiserFS team) might want to
have a chat...

Cheers,
  Trond
