Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261375AbTAMHlk>; Mon, 13 Jan 2003 02:41:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261409AbTAMHlk>; Mon, 13 Jan 2003 02:41:40 -0500
Received: from pat.uio.no ([129.240.130.16]:15756 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S261375AbTAMHlj>;
	Mon, 13 Jan 2003 02:41:39 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15906.28604.625977.386301@charged.uio.no>
Date: Mon, 13 Jan 2003 08:50:20 +0100
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       NFS maillist <nfs@lists.sourceforge.net>
Subject: Re: [PATCH] Secure user authentication for NFS using RPCSEC_GSS [0/6]
In-Reply-To: <20030113022039.GF18756@gtf.org>
References: <15906.1154.649765.791797@charged.uio.no>
	<20030113021951.GE18756@gtf.org>
	<20030113022039.GF18756@gtf.org>
X-Mailer: VM 7.07 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Jeff Garzik <jgarzik@pobox.com> writes:

     > On Sun, Jan 12, 2003 at 09:19:51PM -0500, Jeff Garzik wrote:
    >> OTOH why not do all this authentication and stuff in userspace?

     > Please forgive me: ENOCAFFEINE.  I re-read your mail...

Right. This is doing exactly what you suggested ;-).

All that is added to the kernel is the code that we need to repackage
a user context that was negotiated in userspace into the RPC header.

Cheers,
  Trond
