Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261356AbTAMPKE>; Mon, 13 Jan 2003 10:10:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261370AbTAMPKE>; Mon, 13 Jan 2003 10:10:04 -0500
Received: from crack.them.org ([65.125.64.184]:7333 "EHLO crack.them.org")
	by vger.kernel.org with ESMTP id <S261356AbTAMPKD>;
	Mon, 13 Jan 2003 10:10:03 -0500
Date: Mon, 13 Jan 2003 10:19:01 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org, tridge@samba.org,
       Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Subject: Re: [PATCH] Check compiler version, SMP and PREEMPT.
Message-ID: <20030113151901.GA28149@nevyn.them.org>
Mail-Followup-To: Rusty Russell <rusty@rustcorp.com.au>,
	torvalds@transmeta.com, linux-kernel@vger.kernel.org,
	tridge@samba.org, Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
References: <20030113051434.DC2092C09F@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030113051434.DC2092C09F@lists.samba.org>
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 13, 2003 at 04:13:19PM +1100, Rusty Russell wrote:
> Linus, please apply if you agree.
> 
> Tridge reported getting burned by gcc 3.2 compiled (Debian) XFree
> modules not working on his gcc 2.95-compiled kernel.  Interestingly,
> (as Tridge points out) modversions probably would not have caught the
> change in spinlock size, since the ioctl takes a void*, not a
> structure pointer...

> D: and compiler version (spinlocks change size on UP with gcc major,
> D: at least).

Why does this happen?  It doesn't look like it should, but I only
skimmed the headers checking...

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
