Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129183AbRABW3l>; Tue, 2 Jan 2001 17:29:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129737AbRABW3b>; Tue, 2 Jan 2001 17:29:31 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:57104 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S129734AbRABW3S>; Tue, 2 Jan 2001 17:29:18 -0500
Date: Tue, 2 Jan 2001 22:58:44 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: J Sloan <jjs@toyota.com>
Cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: LVM 0_9-1 woes on 2.4.0-prerelease+diffs
Message-ID: <20010102225844.E7563@athlon.random>
In-Reply-To: <3A52357C.FCB7B187@toyota.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3A52357C.FCB7B187@toyota.com>; from jjs@toyota.com on Tue, Jan 02, 2001 at 12:09:32PM -0800
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 02, 2001 at 12:09:32PM -0800, J Sloan wrote:
> # vgscan
> vgscan: error while loading shared libraries: vgscan: undefined symbol:
> lvm_remove_recursive

This looks like an userspace compilation/installation problem of the new lvm
tools. Make sure you removed the old (0.8*) shared librarians. You can check
which librarains you're using with:

	ldd `which vgscan`

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
