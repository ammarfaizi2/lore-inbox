Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271319AbRHTQNn>; Mon, 20 Aug 2001 12:13:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271320AbRHTQNd>; Mon, 20 Aug 2001 12:13:33 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:7945 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S271319AbRHTQNU>; Mon, 20 Aug 2001 12:13:20 -0400
Subject: Re: PATCH: linux-2.4.9/drivers/i2o to new module_{init,exit} interface
To: adam@yggdrasil.com (Adam J. Richter)
Date: Mon, 20 Aug 2001 17:15:55 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk, deepak@plexity.net, linux-kernel@vger.kernel.org
In-Reply-To: <no.id> from "Adam J. Richter" at Aug 20, 2001 08:15:26 AM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15YriV-0006Ih-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> declarations in linux/Makefile.  (If you really need i2o
> initialization to occur earlier than do_initcalls(), then that would
> also mean that i2o cannot be a module, right?)

In certain configurations you are correct

> 	If you want, I can send you a new patch that changes
> linux/Makefile to initialize i2o before just before drivers/block,
> thereby reproducing the current initialization order, and, of course,

Sounds ok to me - Im not against tidying it up. Note btw the -ac i2o code
is a little different to vanilla and is the 'current' one. I think your
patches will apply fine however as the changes are small
