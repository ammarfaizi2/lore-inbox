Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267224AbTA0Q1t>; Mon, 27 Jan 2003 11:27:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267227AbTA0Q1s>; Mon, 27 Jan 2003 11:27:48 -0500
Received: from [213.86.99.237] ([213.86.99.237]:26090 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S267224AbTA0Q1s>; Mon, 27 Jan 2003 11:27:48 -0500
X-Mailer: exmh version 2.5 01/15/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <Pine.LNX.4.44.0301271019560.18686-100000@chaos.physics.uiowa.edu> 
References: <Pine.LNX.4.44.0301271019560.18686-100000@chaos.physics.uiowa.edu> 
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Cc: Christian Zander <zander@minion.de>, Mark Fasheh <mark.fasheh@oracle.com>,
       Thomas Schlichter <schlicht@uni-mannheim.de>,
       "Randy.Dunlap" <rddunlap@osdl.org>, Sam Ravnborg <sam@ravnborg.org>,
       LKML <linux-kernel@vger.kernel.org>,
       Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: no version magic, tainting kernel. 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 27 Jan 2003 16:29:23 +0000
Message-ID: <8626.1043684963@passion.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


kai@tp1.ruhr-uni-bochum.de said:
>  Okay, I might get persuaded to take that check out if it really makes
> life  harder. Wouldn't it work to not have O_TARGET in the Makefile at
> all, I  think 2.4 shouldn't care as long as you just "make modules"?

Er, I think O_TARGET is in fact the target _module_ name when building
a file system as a module. Try removing O_TARGET from 2.4 fs/ext2/Makefile
and building ext2 as a module.

>  It shouldn't, I kinda deliberately decided to keep the old syntax for
>  this. So it would be a bug.

Ah, OK -- sorry.

--
dwmw2


