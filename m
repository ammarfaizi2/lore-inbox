Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129074AbQKAQft>; Wed, 1 Nov 2000 11:35:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130484AbQKAQfj>; Wed, 1 Nov 2000 11:35:39 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:13372 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S129074AbQKAQf3>; Wed, 1 Nov 2000 11:35:29 -0500
Date: Wed, 1 Nov 2000 17:35:20 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: J Sloan <jjs@pobox.com>
Cc: linux-kernel@vger.kernel.org, linux-lvm@msede.com
Subject: Re: Repeatable oops mounting snapshot fs on 2.4.0-test10
Message-ID: <20001101173520.C17627@athlon.random>
In-Reply-To: <39FF9E2E.5586ADF1@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <39FF9E2E.5586ADF1@pobox.com>; from jjs@pobox.com on Tue, Oct 31, 2000 at 08:38:06PM -0800
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 31, 2000 at 08:38:06PM -0800, J Sloan wrote:
> version a spin for the very first time when I ran into
> some big problems:

Check your userspace tools. The kernel trusts the data that arrives from the
userspace tools. If the data that arrives from userspace is wrong the kernel
will malfunction. On the kernel list a few days ago I pointed out an userspace
tools package that works for me.

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
