Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264205AbTCXNzZ>; Mon, 24 Mar 2003 08:55:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264207AbTCXNzZ>; Mon, 24 Mar 2003 08:55:25 -0500
Received: from pat.uio.no ([129.240.130.16]:13224 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S264205AbTCXNzZ>;
	Mon, 24 Mar 2003 08:55:25 -0500
To: Richard Curnow <Richard.Curnow@superh.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: struct nfs_fattr alignment problem in nfs3proc.c
References: <20030321175206.GA17163@malvern.uk.w2k.superh.com>
	<shs7karzmwv.fsf@charged.uio.no>
	<20030324120923.GB17163@malvern.uk.w2k.superh.com>
	<20030324134927.GC17163@malvern.uk.w2k.superh.com>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 24 Mar 2003 15:06:24 +0100
In-Reply-To: <20030324134927.GC17163@malvern.uk.w2k.superh.com>
Message-ID: <shsel4wsvtr.fsf@charged.uio.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Honest Recruiter)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Richard Curnow <Richard.Curnow@superh.com> writes:

     > + if (((unsigned long) arg & 0x7) != 0) {
     > + printk("nfs3_proc_unlink_setup : arg not 8-byte aligned!\n");
     > + }
     > + if (((unsigned long) res & 0x7) != 0) {
     > + printk("nfs3_proc_unlink_setup : res not 8-byte aligned!\n");
     > + }

Nope...

Cheers,
  Trond
