Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261221AbTEALzq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 May 2003 07:55:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261225AbTEALzq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 May 2003 07:55:46 -0400
Received: from pat.uio.no ([129.240.130.16]:6884 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S261221AbTEALzp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 May 2003 07:55:45 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16049.3613.644858.967073@charged.uio.no>
Date: Thu, 1 May 2003 14:07:57 +0200
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>,
       Bojan Smojver <bojan@rexursive.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.68: NFS3+exported /mnt/cdrom+eject: system lockup
In-Reply-To: <1051790160.1960.6.camel@teapot.felipe-alfaro.com>
References: <1051754203.3eb07edb09c51@imp.rexursive.com>
	<shsd6j3gdan.fsf@charged.uio.no>
	<1051790160.1960.6.camel@teapot.felipe-alfaro.com>
X-Mailer: VM 7.07 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Felipe Alfaro Solana <felipe_alfaro@linuxmail.org> writes:

     > However, during shutdown (it's a RH9 box), I do get "can't
     > unmount, device is busy" errors while unmounting this
     > filesystem *after* the NFS server has been stopped and all
     > shares unexported.

That's a known bug and I believe Neil is looking into it.

     > Anyways, I'm having problems with NFS on 2.5... many programs
     > fail when accessing files over NFS, normally, programs that
     > perform heavy file seeks, writes and reads, like "oggdec" or
     > "lame". They usually can't complete without exitting with
     > errors.

I'll take on any NFS client problems. If you are having problems with
a 2.5.x client failing against a 2.4.x server (note! 2.5.x servers are
still way too buggy) or a non-linux server, then please send me a
full bugreport.

Cheers,
  Trond
