Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284951AbRLQBeB>; Sun, 16 Dec 2001 20:34:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284955AbRLQBdv>; Sun, 16 Dec 2001 20:33:51 -0500
Received: from mons.uio.no ([129.240.130.14]:57220 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S284952AbRLQBdc>;
	Sun, 16 Dec 2001 20:33:32 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15389.19300.179304.433697@charged.uio.no>
Date: Mon, 17 Dec 2001 02:33:24 +0100
To: Dave Jones <davej@suse.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: More fun with fsx.
In-Reply-To: <Pine.LNX.4.33.0112170116160.29678-100000@Appserv.suse.de>
In-Reply-To: <15389.13714.559348.873531@charged.uio.no>
	<Pine.LNX.4.33.0112170116160.29678-100000@Appserv.suse.de>
X-Mailer: VM 6.92 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Dave Jones <davej@suse.de> writes:

     > On Mon, 17 Dec 2001, Trond Myklebust wrote:
    >> tcpdump -s 256 -w tcpdump.out

     > also added "host equinox" (this is on a hub, and wanted to cut
     > out the noise), let me know if you want the unfiltered version.

No. I think I've got it. You are running NFSv2 (I assumed v3) and I'll
bet that if you look in your syslog, you'll see the error message

NFS: Odd RPC header size in read reply: 

Am I right?

This is a bug that was fixed ages ago in the NFSv3 code. I've updated
the 'fattr' patch yet again...

Cheers,
   Trond
