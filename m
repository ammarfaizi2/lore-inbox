Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271801AbRH1QOX>; Tue, 28 Aug 2001 12:14:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271805AbRH1QON>; Tue, 28 Aug 2001 12:14:13 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:28688 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S271801AbRH1QOF>; Tue, 28 Aug 2001 12:14:05 -0400
Subject: Re: Size of pointers in sys_call_table?
To: bgerst@didntduck.org (Brian Gerst)
Date: Tue, 28 Aug 2001 17:17:24 +0100 (BST)
Cc: haba@pdc.kth.se (Harald Barth), linux-kernel@vger.kernel.org
In-Reply-To: <3B8B9C00.4842710D@didntduck.org> from "Brian Gerst" at Aug 28, 2001 09:26:24 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15blYK-0006Fb-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The layout of the sys_call_table is totally architecture dependant.  The
> question to ask here is why do you need to use it?  Modifying it to hook
> into syscalls is frowned upon.

And potentially unsafe (think about caching, and non atomic writes on
some platforms)

