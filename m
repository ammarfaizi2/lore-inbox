Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266967AbSK2Gnq>; Fri, 29 Nov 2002 01:43:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266969AbSK2Gnq>; Fri, 29 Nov 2002 01:43:46 -0500
Received: from pat.uio.no ([129.240.130.16]:8600 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S266967AbSK2Gnp>;
	Fri, 29 Nov 2002 01:43:45 -0500
To: KELEMEN Peter <fuji@elte.hu>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>, linux-kernel@vger.kernel.org
Subject: Re: NFS performance ...
References: <200211241521.09981.m.c.p@wolk-project.de>
	<20021128110627.GD26875@chiara.elte.hu>
	<shs65uh1wch.fsf@charged.uio.no>
	<20021128213612.GB6321@chiara.elte.hu>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 29 Nov 2002 07:51:05 +0100
In-Reply-To: <20021128213612.GB6321@chiara.elte.hu>
Message-ID: <shsznrs98di.fsf@charged.uio.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == KELEMEN Peter <fuji@elte.hu> writes:


     > 2.4.20rc2aa1 with my .config, NFS sucked.  make menuconfig,
     > turned off CONFIG_NFS_DIRECTIO, make -j2 bzImage modules
     > modules_install (no compiler errors), install kernel, lilo,
     > reboot, NFS flies.  Confirmed on other machine as well.  gcc is
     > 3.2.1 (Debian sid).  Wish to seek more input on the case?

I'd rather see if you can reproduce it on stock 2.4.20-pre4 + the
NFS_ALL patch. I have a strong feeling that this is something that is
particular to the aa kernels...

Cheers,
  Trond
