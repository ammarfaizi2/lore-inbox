Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129061AbQKKBfD>; Fri, 10 Nov 2000 20:35:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129103AbQKKBex>; Fri, 10 Nov 2000 20:34:53 -0500
Received: from smtp-fwd.valinux.com ([198.186.202.196]:6665 "EHLO
	mail.valinux.com") by vger.kernel.org with ESMTP id <S129061AbQKKBej>;
	Fri, 10 Nov 2000 20:34:39 -0500
Date: Fri, 10 Nov 2000 17:35:25 -0800
From: David Hinds <dhinds@valinux.com>
To: linux-kernel@vger.kernel.org
Subject: Re: PCMCIA versioning...
Message-ID: <20001110173525.A27291@valinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Is there actually a way to work out what version of userspace
> utilities you are using? 

Right now, no; the user space utilities grab the version number from
the header files.  I haven't figured out a sane way to straighten this
out; this was the best I could come up with for now.  In general, the
version of the kernel stuff is what matters: the user space tools
don't change much, and the API is pretty much static, so you don't
need to recompile them all the time.

-- Dave
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
