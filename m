Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284955AbRLQBsL>; Sun, 16 Dec 2001 20:48:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284964AbRLQBrv>; Sun, 16 Dec 2001 20:47:51 -0500
Received: from mons.uio.no ([129.240.130.14]:13957 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S284963AbRLQBrq>;
	Sun, 16 Dec 2001 20:47:46 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15389.20155.378980.692209@charged.uio.no>
Date: Mon, 17 Dec 2001 02:47:39 +0100
To: Dave Jones <davej@suse.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: More fun with fsx.
In-Reply-To: <Pine.LNX.4.33.0112170236290.29678-100000@Appserv.suse.de>
In-Reply-To: <15389.19300.179304.433697@charged.uio.no>
	<Pine.LNX.4.33.0112170236290.29678-100000@Appserv.suse.de>
X-Mailer: VM 6.92 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Dave Jones <davej@suse.de> writes:

     > The only stuff that looks related is...

     > call_verify: server accept status: 2 call_verify: server accept
     > status: 2 call_verify: server accept status: 2 RPC: garbage,
     > exit EIO nfs_get_root: getattr error = 5

Are the timestamps correct? If the server is replying with a 'garbage'
message, then certainly that will result in an EIO. However I didn't
see anything like that in your tcpdump, and the juxtaposed
'nfs_get_root' error rather points to that as being a mount error.

Cheers,
  Trond
