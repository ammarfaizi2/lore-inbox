Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265647AbUBCVYU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Feb 2004 16:24:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265709AbUBCVYU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Feb 2004 16:24:20 -0500
Received: from fw.osdl.org ([65.172.181.6]:47248 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265647AbUBCVYT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Feb 2004 16:24:19 -0500
Date: Tue, 3 Feb 2004 13:18:15 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Matt Mackall <mpm@selenic.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] add syscalls.h
Message-Id: <20040203131815.68030c0a.rddunlap@osdl.org>
In-Reply-To: <20040203202916.GC31138@waste.org>
References: <20040130163547.2285457b.rddunlap@osdl.org>
	<20040201222254.39bc5b39.rddunlap@osdl.org>
	<20040201224344.43d1c37d.akpm@osdl.org>
	<20040203202916.GC31138@waste.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Feb 2004 14:29:16 -0600 Matt Mackall <mpm@selenic.com> wrote:

| On Sun, Feb 01, 2004 at 10:43:44PM -0800, Andrew Morton wrote:
| > +extern asmlinkage long sys_unlink(const char __user *pathname);
| > +extern asmlinkage long sys_chmod(const char __user *filename, mode_t mode);
| > +extern asmlinkage long sys_fchmod(unsigned int fd, mode_t mode);
| > 
| > Maybe lose the `extern' too.  It's just a waste of space.  I normally put
| > it in for consistency if the surrounding code is done that way, but for a
| > new header file, why bother?
| 
| I'd really like to see the extern go, if only to discourage that
| particular bit of cargo cult programming. There are actually people
| who think it serves a purpose..

They are already gone in the v2 version of the patch.

--
~Randy
kernel-janitors project:  http://janitor.kernelnewbies.org/
