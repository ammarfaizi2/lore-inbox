Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314093AbSEMQQZ>; Mon, 13 May 2002 12:16:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314094AbSEMQQZ>; Mon, 13 May 2002 12:16:25 -0400
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:18839 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S314093AbSEMQQY>; Mon, 13 May 2002 12:16:24 -0400
Date: Mon, 13 May 2002 11:16:07 -0500 (CDT)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
cc: Pete Zaitcev <zaitcev@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Strange s390 code in 2.4.19-pre8
In-Reply-To: <OFFA479633.3A335CB7-ONC1256BB8.002ABB8D@de.ibm.com>
Message-ID: <Pine.LNX.4.44.0205131114420.19498-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 May 2002, Martin Schwidefsky wrote:

> > #2 - strange changes to net Makefile
> The intention of this is to have fsm.o built as a module if ctc
> and iucv are built as modules too. I agree that this is broken
> if one of {iucv,ctc} is built as a module and the other is built
> in.

Actually, I don't think it's broken, Rules.make takes care of that case 
and compiles fsm.o into the kernel in the latter case, it does not build 
a fsm.o module.

--Kai


