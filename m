Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276248AbRJUPUq>; Sun, 21 Oct 2001 11:20:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276255AbRJUPU0>; Sun, 21 Oct 2001 11:20:26 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:44048 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S276248AbRJUPUV>; Sun, 21 Oct 2001 11:20:21 -0400
Subject: Re: [PATCH] binfmt_misc.c, kernel-2.4.12
To: albertb@nt.kegel.com.pl (Albert Bartoszko)
Date: Sun, 21 Oct 2001 16:26:32 +0100 (BST)
Cc: rguenth@tat.physik.uni-tuebingen.de, linux-kernel@vger.kernel.org
In-Reply-To: <001e01c15894$cfdf3340$0100050a@abartoszko> from "Albert Bartoszko" at Oct 19, 2001 01:54:23 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15vKUi-0006hc-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I find bug in  binfmt_misc.c from kernel 2.4.12 source. The read() syscal
> return bad value, causes some application SIGSEGV.

This has been fixed in the -ac tree since early 2.4, but Linus didnt want
the fs based binfmt changes
