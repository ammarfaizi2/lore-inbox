Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314221AbSEMQdq>; Mon, 13 May 2002 12:33:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314227AbSEMQdp>; Mon, 13 May 2002 12:33:45 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:7107 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S314221AbSEMQdm>; Mon, 13 May 2002 12:33:42 -0400
Date: Mon, 13 May 2002 12:32:37 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Cc: Pete Zaitcev <zaitcev@redhat.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Strange s390 code in 2.4.19-pre8
Message-ID: <20020513123237.C6208@devserv.devel.redhat.com>
In-Reply-To: <20020513122330.B6208@devserv.devel.redhat.com> <Pine.LNX.4.44.0205131125250.19498-100000@chaos.physics.uiowa.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Date: Mon, 13 May 2002 11:30:06 -0500 (CDT)
> From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>

> I think I see two easy way to resolve the problem:
> o backport the Rules.make change (it's been in 2.5 for months w/o even
>   anybody noticing it, so it's definitely stable)
> o Move the EXPORT_SYMBOL() in drivers/isdn/hisax/fsm.o into
>   drivers/isdn/hisax/config.o

If ISDN people are willing to do that, it would be a great
relief. I did not raise this question because undoubtedly
they were using fsm.c first, so it was s390 mistake (accorting
to the comment in the drivers/s390/net/fsm.c).

-- Pete
