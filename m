Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314136AbSEMQZZ>; Mon, 13 May 2002 12:25:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314106AbSEMQZY>; Mon, 13 May 2002 12:25:24 -0400
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:23191 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S314136AbSEMQZW>; Mon, 13 May 2002 12:25:22 -0400
Date: Mon, 13 May 2002 11:25:19 -0500 (CDT)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Pete Zaitcev <zaitcev@redhat.com>
cc: Martin Schwidefsky <schwidefsky@de.ibm.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Strange s390 code in 2.4.19-pre8
In-Reply-To: <20020513121933.A6208@devserv.devel.redhat.com>
Message-ID: <Pine.LNX.4.44.0205131122120.19498-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 May 2002, Pete Zaitcev wrote:

> > Actually, I don't think it's broken, Rules.make takes care of that case 
> > and compiles fsm.o into the kernel in the latter case, it does not build 
> > a fsm.o module.
>
> Obviously, the guy who did the change expected it to work
> like you described, but he never tested it, and it doesn't.
> ctc fails to load with init_fsm undefined.
> It would work if EXPORT_SYMBOL_NOVERS were involved.

Not sure if I understand you correctly. I mean it should work w/o 
CONFIG_MODVERSIONS, and it would also work with CONFIG_MODVERSIONS if it 
wasn't for the conflict with the ISDN fsm.o. Do we agree here?

--Kai



