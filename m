Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267388AbUIASUX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267388AbUIASUX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 14:20:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267408AbUIASUX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 14:20:23 -0400
Received: from umhlanga.stratnet.net ([12.162.17.40]:36624 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S267388AbUIASUU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 14:20:20 -0400
To: Chris Wright <chrisw@osdl.org>
Cc: viro@parcelfarce.linux.theplanet.co.uk, discuss@x86-64.org,
       linux-kernel@vger.kernel.org
Subject: Re: f_ops flag to speed up compatible ioctls in linux kernel
X-Message-Flag: Warning: May contain useful information
References: <20040901072245.GF13749@mellanox.co.il>
	<20040901073218.GQ16297@parcelfarce.linux.theplanet.co.uk>
	<52zn4a0ysg.fsf@topspin.com> <20040901110225.D1973@build.pdx.osdl.net>
From: Roland Dreier <roland@topspin.com>
Date: Wed, 01 Sep 2004 11:12:46 -0700
In-Reply-To: <20040901110225.D1973@build.pdx.osdl.net> (Chris Wright's
 message of "Wed, 1 Sep 2004 11:02:25 -0700")
Message-ID: <52656x26zl.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 01 Sep 2004 18:12:47.0016 (UTC) FILETIME=[48B9AA80:01C4904F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Chris> You forgot a driver specific filesystem which exposes
    Chris> requests in a file per request type style.  Also, there's a
    Chris> simple_transaction type of file which can allow you
    Chris> send/recv data and should eliminate the need for tagging.
    Chris> Example, look at nfsd fs (fs/nfsd/nfsctl.c).

Thanks, I'll take a look at this.  How does one handle the 32-bit
userspace / 64-bit kernel compat layer in this setup?

 - R.

