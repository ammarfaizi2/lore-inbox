Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261295AbTATFwN>; Mon, 20 Jan 2003 00:52:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261368AbTATFwN>; Mon, 20 Jan 2003 00:52:13 -0500
Received: from rth.ninka.net ([216.101.162.244]:47767 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id <S261295AbTATFwM>;
	Mon, 20 Jan 2003 00:52:12 -0500
Subject: Re: strange sparc64 -> i586 intermittent but reproducible NFS write
	errors to one and only one fs
From: "David S. Miller" <davem@redhat.com>
To: trond.myklebust@fys.uio.no
Cc: Nix <nix@esperi.demon.co.uk>, ultralinux@vger.kernel.org,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
In-Reply-To: <15915.4574.380686.123067@charged.uio.no>
References: <87bs2q3paq.fsf@amaterasu.srvr.nix>
	<200301100658.h0A6vxs14580@Port.imtp.ilyichevsk.odessa.ua>
	<87iswkx53u.fsf@amaterasu.srvr.nix> 
	<15915.4574.380686.123067@charged.uio.no>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 19 Jan 2003 22:38:34 -0800
Message-Id: <1043044714.10408.0.camel@rth.ninka.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-01-19 at 13:00, Trond Myklebust wrote:
> It sounds rather strange that this particular patch should introduce
> an EIO, but here it is (fresh from BitKeeper)

It is possible in the context of the change causing a miscompile.
Another possibility is just timing differences causing different
sequences of events to occur than before.

