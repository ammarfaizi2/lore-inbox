Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262454AbUK0AUP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262454AbUK0AUP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 19:20:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262436AbUKZX6T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 18:58:19 -0500
Received: from zeus.kernel.org ([204.152.189.113]:9413 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S263071AbUKZTld (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 14:41:33 -0500
Subject: Re: dequeue_signal() in signal.c disabilities
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: David Chow <davidchow@shaolinmicro.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <41A14E0B.3030608@shaolinmicro.com>
References: <41A14E0B.3030608@shaolinmicro.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1101337666.2571.4.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 24 Nov 2004 23:07:47 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2004-11-22 at 02:25, David Chow wrote:
> This causes disabilities with modules that are non pure GPL licensed,
> this causes kernel threads or possibly other interrupts unable to be
> handled properly. I've tried both BSD and LGPL which doesn't work. The
> dequeue_signal() is essential to anyone who use sleeps with signals and

If the code is BSD or LGPL licensed then you can stick a GPL license on
the
copy for your kernel anyway and follow the rules for the GPL. That
doesn't in
any way take away the right for it to be used with some other license
separately to the kernel.

