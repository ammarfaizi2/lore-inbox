Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129267AbRAIAxc>; Mon, 8 Jan 2001 19:53:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129383AbRAIAxY>; Mon, 8 Jan 2001 19:53:24 -0500
Received: from hermes.mixx.net ([212.84.196.2]:13575 "HELO hermes.mixx.net")
	by vger.kernel.org with SMTP id <S129267AbRAIAxK>;
	Mon, 8 Jan 2001 19:53:10 -0500
Message-ID: <3A5A6039.DFD42986@innominate.de>
Date: Tue, 09 Jan 2001 01:50:01 +0100
From: Daniel Phillips <phillips@innominate.de>
Organization: innominate
X-Mailer: Mozilla 4.72 [de] (X11; U; Linux 2.4.0-test10 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Jeff Dike <jdike@karaya.com>
Cc: user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [uml-devel] Re: [reiserfs-list] BUG at inode.c:371
In-Reply-To: <20010108231238.3795.qmail@utkmath3.math.utk.edu> <200101090147.UAA05211@ccure.karaya.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Dike wrote:
> 
> You've got two problems here, and one of them is mine:
> 
> > In uml I continue the debian installation off of cdrom and as I say ok
> > to the final screen I get a "Kernel panic: Kernel mode fault at addr
> > 0xbefffe90, ip 0x1009f315" from user-mode linux which is running as
> > me, not as root.
> 
> Can you get me a stack trace from the panic?  See http://user-mode-linux.source
> forge.net/trouble.html if you need information on doing that.

I don't know about your panic but the BUG itself is related to dirty
page handling on inodes and is already cleaned up in 2.4.0.

--
Daniel
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
