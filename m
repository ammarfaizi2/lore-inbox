Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751380AbWCSCpF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751380AbWCSCpF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Mar 2006 21:45:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751298AbWCSCpF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Mar 2006 21:45:05 -0500
Received: from thunk.org ([69.25.196.29]:39610 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S1751291AbWCSCpC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Mar 2006 21:45:02 -0500
Date: Sat, 18 Mar 2006 21:44:58 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Takashi Sato <sho@tnes.nec.co.jp>
Cc: ext2-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [Ext2-devel] [PATCH 2/2] ext2/3: Support 2^32-1 blocks(e2fsprogs)
Message-ID: <20060319024458.GB19607@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Takashi Sato <sho@tnes.nec.co.jp>, ext2-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
References: <000401c6482d$880adfa0$4168010a@bsd.tnes.nec.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000401c6482d$880adfa0$4168010a@bsd.tnes.nec.co.jp>
User-Agent: Mutt/1.5.11+cvs20060126
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 15, 2006 at 09:39:41PM +0900, Takashi Sato wrote:
> This makes it possible to make ext2/3 with 4G-1(2^32-1) blocks by mke2fs
> in e2fsprogs-1.38.
> 
> Signed-off-by: Takashi Sato sho@tnes.nec.co.jp

I've checked in all but the lib/bitops.c change.  I want to wait and
confirm that it is really necessary before commiting it.

						- Ted
