Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274683AbRJAHbs>; Mon, 1 Oct 2001 03:31:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274669AbRJAHbi>; Mon, 1 Oct 2001 03:31:38 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:48394 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S274683AbRJAHb2>; Mon, 1 Oct 2001 03:31:28 -0400
Subject: Re: 2.4.10-ac1 with gcc-3.0.1 compile error!
To: haiquy@yahoo.com (=?iso-8859-1?q?Steve=20Kieu?=)
Date: Mon, 1 Oct 2001 08:36:56 +0100 (BST)
Cc: linux-kernel@vger.kernel.org (kernel)
In-Reply-To: <20011001064308.52994.qmail@web10408.mail.yahoo.com> from "=?iso-8859-1?q?Steve=20Kieu?=" at Oct 01, 2001 04:43:08 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15nxdI-0000To-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> -mpreferred-stack-boundary=2 -march=i686    -c -o
> timer.o timer.c
> timer.c:35: conflicting types for `xtime'
> /home/sk/src/linux/include/linux/sched.h:573: previous

Thanks. I forgot to remote the volatile from the sched.h case now that
Linus tree seems to have proved its not needed
