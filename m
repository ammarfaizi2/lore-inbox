Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284934AbRLQABB>; Sun, 16 Dec 2001 19:01:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284938AbRLQAAv>; Sun, 16 Dec 2001 19:00:51 -0500
Received: from pat.uio.no ([129.240.130.16]:36255 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S284934AbRLQAAd>;
	Sun, 16 Dec 2001 19:00:33 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15389.13714.559348.873531@charged.uio.no>
Date: Mon, 17 Dec 2001 01:00:18 +0100
To: Dave Jones <davej@suse.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: More fun with fsx.
In-Reply-To: <Pine.LNX.4.33.0112162226460.16845-100000@Appserv.suse.de>
In-Reply-To: <15389.4070.855955.296791@charged.uio.no>
	<Pine.LNX.4.33.0112162226460.16845-100000@Appserv.suse.de>
X-Mailer: VM 6.92 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Dave Jones <davej@suse.de> writes:

     > On Sun, 16 Dec 2001, Trond Myklebust wrote:
    >> In that case, I'll need a tcpdump of the point at which the
    >> error occurs.

     > Sure no problem... any particular preferred options ?  Want
     > client and server, or just client ?

Client should suffice. If you could start something like

tcpdump -s 256 -w tcpdump.out

close to the point at which the error occurs, and send me the
resulting file, then that should be OK. I'm mainly out to check
whether or not the server is the one returning the EIO error, or
possibly if it is returning bad post-op attributes. Those are the only
remaining possibilities if hard mounts are being used.

BTW: could you also tell me a bit about the server? Is this an ext[23]
partition and knfsd? I'm still a bit wary of ReiserFS...

Cheers,
   Trond
