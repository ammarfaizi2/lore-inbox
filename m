Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271739AbRHQWIE>; Fri, 17 Aug 2001 18:08:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271728AbRHQWH4>; Fri, 17 Aug 2001 18:07:56 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:49682 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S271734AbRHQWHU>; Fri, 17 Aug 2001 18:07:20 -0400
Subject: Re: UID16 stuff..
To: airlied@csn.ul.ie (Dave Airlie)
Date: Fri, 17 Aug 2001 23:10:00 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.32.0108172303500.4995-100000@skynet> from "Dave Airlie" at Aug 17, 2001 11:04:14 PM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15XroW-0008C0-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> following on from my syscall compat query last night.. should a new
> architecture need the CONFIG_UID16 and associated changes to system call
> table? or should it go without them...
> 
> so I suppose are we moving towards this or away from it?

uid16 is compat stuff, you can lose that too. It might be useful to keep
around if you want to do ultrix or ancientbsd binary compat
