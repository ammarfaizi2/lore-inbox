Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135963AbRD0AmG>; Thu, 26 Apr 2001 20:42:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135965AbRD0Al4>; Thu, 26 Apr 2001 20:41:56 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:14948 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S135963AbRD0Alk>; Thu, 26 Apr 2001 20:41:40 -0400
Date: Fri, 27 Apr 2001 02:35:33 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Alexander Viro <viro@math.psu.edu>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] SMP race in ext2 - metadata corruption.
Message-ID: <20010427023533.B678@athlon.random>
In-Reply-To: <20010427020524.A678@athlon.random> <Pine.LNX.4.31.0104261717540.4310-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.31.0104261717540.4310-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Thu, Apr 26, 2001 at 05:19:26PM -0700
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 26, 2001 at 05:19:26PM -0700, Linus Torvalds wrote:
> Detail nit: don't do this. Use "current_text_addr()" instead. Simpler to
> read, and gcc will actually do the right thing wrt inlining etc.

Agreed, thanks for the info.

Andrea
