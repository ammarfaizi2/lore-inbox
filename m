Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269193AbUI3Lay@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269193AbUI3Lay (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 07:30:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269184AbUI3Lay
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 07:30:54 -0400
Received: from coyote.holtmann.net ([217.160.111.169]:61923 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S269237AbUI3Law
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 07:30:52 -0400
Subject: Re: [PATCH] drivers/isdn/i4l/isdn_tty.c in BK HEAD doesn't compile
From: Marcel Holtmann <marcel@holtmann.org>
To: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20040930095528.GA19457@cip.informatik.uni-erlangen.de>
References: <20040930095528.GA19457@cip.informatik.uni-erlangen.de>
Content-Type: text/plain
Message-Id: <1096543875.4671.1.camel@notepaq>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 30 Sep 2004 13:31:15 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

> (excalibur) [/scratch/src/excalibur] make
>   CHK     include/linux/version.h
> make[1]: `arch/i386/kernel/asm-offsets.s' is up to date.
>   CHK     include/linux/compile.h
>   CC      drivers/isdn/i4l/isdn_tty.o
> drivers/isdn/i4l/isdn_tty.c: In function `isdn_tty_modem_result':
> drivers/isdn/i4l/isdn_tty.c:2676: error: `tty' undeclared (first use in this function)
> drivers/isdn/i4l/isdn_tty.c:2676: error: (Each undeclared identifier is reported only once
> drivers/isdn/i4l/isdn_tty.c:2676: error: for each function it appears in.)
> make[3]: *** [drivers/isdn/i4l/isdn_tty.o] Error 1
> make[2]: *** [drivers/isdn/i4l] Error 2
> make[1]: *** [drivers/isdn] Error 2
> make: *** [drivers] Error 2
> 
> 
> patch applied.

I already sent a patch for it some hours ago, because there a similar
problem for the CAPI.

Regards

Marcel


