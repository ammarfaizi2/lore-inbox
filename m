Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130520AbRBQTXJ>; Sat, 17 Feb 2001 14:23:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131169AbRBQTW7>; Sat, 17 Feb 2001 14:22:59 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:21280 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S130520AbRBQTWx>; Sat, 17 Feb 2001 14:22:53 -0500
Date: Sat, 17 Feb 2001 20:23:31 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: David Mansfield <lkml@dm.ultramaster.com>
Cc: Sasi Peter <sape@iq.rulez.org>,
        Godfrey Livingstone <godfrey@hattaway-associates.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Ingo's RAID patch for 2.2.18 final?
Message-ID: <20010217202331.J30401@athlon.random>
In-Reply-To: <200101241505.QAA01045@iq.rulez.org> <20010216151737.D14430@inspiron.random> <3A8D4D0F.5EB9BDB1@dm.ultramaster.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3A8D4D0F.5EB9BDB1@dm.ultramaster.com>; from lkml@dm.ultramaster.com on Fri, Feb 16, 2001 at 10:53:51AM -0500
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 16, 2001 at 10:53:51AM -0500, David Mansfield wrote:
> This may be a bit OT, but when you say O_DIRECT, that implies that you
> can pass that flag to open(2) and it will bypass the page cache, and

yes.

> read directly into user-space buffers (zero-copy IO)?  Does this also

yes.

> bypass the read-ahead mechanisms in the kernel?  Does it imply O_SYNC?

yes.

It's rawio through the fs. It's not included into 2.4-latest yet.

Andrea
