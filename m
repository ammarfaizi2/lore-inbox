Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132616AbRADU0L>; Thu, 4 Jan 2001 15:26:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133010AbRADUZn>; Thu, 4 Jan 2001 15:25:43 -0500
Received: from zeus.kernel.org ([209.10.41.242]:46601 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S132632AbRADUZY>;
	Thu, 4 Jan 2001 15:25:24 -0500
Date: Thu, 4 Jan 2001 20:23:30 +0000
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexander Viro <aviro@redhat.com>,
        "Stephen C. Tweedie" <sct@redhat.com>, "Marco d'Itri" <md@Linux.IT>,
        Jeff Lightfoot <jeffml@pobox.com>, Dan Aloni <karrde@callisto.yi.org>,
        Anton Blanchard <anton@linuxcare.com.au>
Subject: Re: test13-pre6
Message-ID: <20010104202330.J1290@redhat.com>
In-Reply-To: <Pine.LNX.4.10.10012291609470.1123-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <Pine.LNX.4.10.10012291609470.1123-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Fri, Dec 29, 2000 at 04:25:43PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Dec 29, 2000 at 04:25:43PM -0800, Linus Torvalds wrote:
> 
> Stephen: mind trying your fsync/etc tests on this one, to verify that the
> inode dirty stuff is all done right?

Back from the Scottish Hogmanay celebrations now. :)  I've run my
normal tests on this (based mainly on timing tests which show up
exactly how much is being written to disk for 1000 iterations of
various fsync/fdatasync/O_SYNC and overwrite/append combinations) and
2.4.0-prerelease seems to be doing the Right Thing.

My standard tests for this don't cover msync --- do you want me to
give that a try too?

--Stephen
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
