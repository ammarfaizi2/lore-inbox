Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281773AbRKQQQB>; Sat, 17 Nov 2001 11:16:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281776AbRKQQPu>; Sat, 17 Nov 2001 11:15:50 -0500
Received: from smtp02.uc3m.es ([163.117.136.122]:23312 "HELO smtp.uc3m.es")
	by vger.kernel.org with SMTP id <S281773AbRKQQPe>;
	Sat, 17 Nov 2001 11:15:34 -0500
From: "Peter T. Breuer" <ptb@it.uc3m.es>
Message-Id: <200111171615.fAHGFM027673@oboe.it.uc3m.es>
Subject: Re: Raw access to block devices
In-Reply-To: <20011117154448.97910.qmail@web21101.mail.yahoo.com> from "Roy S.C.
 Ho" at "Nov 17, 2001 07:44:48 am"
To: "Roy S.C. Ho" <scho1208@yahoo.com>
Date: Sat, 17 Nov 2001 17:15:22 +0100 (MET)
Cc: linux-kernel@vger.kernel.org, scho@whizztech.com
X-Anonymously-To: 
Reply-To: ptb@it.uc3m.es
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"A month of sundays ago Roy S.C. Ho wrote:"
> I would like to write a driver for a block device that
> is better to be accessed directly without going
> through the buffer cache. I read the source code raw.c
> and learnt that linux does have raw I/O support.
> However, it seems to me that the support only provides
> a character device interface to users. Is there a

I think that's the control device. You can work out how to use it
by looking at the ioctls in raw.c. But, yes, sure, if you get some
"official" news on how to work it, let me know too and I'll use the
info like a shot!

> simple way to maintain the block device interface to
> user programs / other parts of the kernel, while
> bypassing the buffer cache system?

Peter
