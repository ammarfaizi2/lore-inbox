Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268325AbUHaM4t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268325AbUHaM4t (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 08:56:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268144AbUHaMwu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 08:52:50 -0400
Received: from the-village.bc.nu ([81.2.110.252]:10887 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S268396AbUHaMuB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 08:50:01 -0400
Subject: Re: Kernel Module Compilation Error
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jeba Anandhan A <jeba_career@yahoo.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040831123944.38866.qmail@web50608.mail.yahoo.com>
References: <20040831123944.38866.qmail@web50608.mail.yahoo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1093952875.32682.14.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 31 Aug 2004 12:47:56 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2004-08-31 at 13:39, Jeba Anandhan A wrote:
> # gcc -c -DMODULE -D__KERNEL__ currenttask.c
> the following error is shown.
> what should i do?.

You need to build against the kernel headers not the C library headers.
For FC1 see the kernel-source package and for 2.6 see /lib/modules/...
which now contains the right header set and is a more standardised way
of doing it

