Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277027AbRJHRTS>; Mon, 8 Oct 2001 13:19:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276534AbRJHRTH>; Mon, 8 Oct 2001 13:19:07 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:15119 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S276556AbRJHRSs>; Mon, 8 Oct 2001 13:18:48 -0400
Subject: Re: Desperately missing a working "pselect()" or similar...
To: lkv@isg.de
Date: Mon, 8 Oct 2001 18:24:45 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        linux-kernel@vger.kernel.org (Kernel Linux)
In-Reply-To: <3BC1DD17.EACD968@isg.de> from "lkv@isg.de" at Oct 08, 2001 07:06:31 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15qe8z-0001EL-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > siglongjmp doesnt have to make any syscalls so intuitively I'd say it
> > ought to be more efficient
> 
> Are you sure? Doesn't sigsetjmp() call sigprocmask in order to obtain
> the current signal mask?

and intuition is a dangerouns thing. I didnt realise glibc didnt cache
the procmask
