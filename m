Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261305AbUKBSev@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261305AbUKBSev (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 13:34:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261280AbUKBSeu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 13:34:50 -0500
Received: from chello083144090118.chello.pl ([83.144.90.118]:47877 "EHLO
	plus.ds14.agh.edu.pl") by vger.kernel.org with ESMTP
	id S261306AbUKBSel (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 13:34:41 -0500
From: =?utf-8?q?Pawe=C5=82_Sikora?= <pluto@pld-linux.org>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Subject: Re: [oops] lib/vsprintf.c
Date: Tue, 2 Nov 2004 19:34:38 +0100
User-Agent: KMail/1.7.1
References: <200411020719.55570.pluto@pld-linux.org> <Pine.LNX.4.53.0411020802410.13921@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.53.0411020802410.13921@yvahk01.tjqt.qr>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411021934.38802.pluto@pld-linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 02 of November 2004 08:03, you wrote:
> >Hi,
> >
> >
> >static int km_init_module(void)
> >{
> >    printk(KERN_DEBUG "%s init\n", 1.4);
> >    return 0;
> >}
>
> You do know that %s does not mix with 1.4?

Yes, I known. I did it intentionally.
IMHO kernel should be more resistant to accidental programmers errors.
Be secure, trust no one ;)
... and catch bugs with http://netlab.ru.is/exception/KernelExceptions.pdf

-- 
/* Copyright (C) 2003, SCO, Inc. This is valuable Intellectual Property. */

                           #define say(x) lie(x)
