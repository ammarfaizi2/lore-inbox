Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265833AbUGDWw3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265833AbUGDWw3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jul 2004 18:52:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265840AbUGDWw3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jul 2004 18:52:29 -0400
Received: from mail5.tpgi.com.au ([203.12.160.101]:56007 "EHLO
	mail5.tpgi.com.au") by vger.kernel.org with ESMTP id S265833AbUGDWw2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jul 2004 18:52:28 -0400
Subject: Re: [PATCH] kernel/power/swsusp.c
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Erik Rigtorp <erik@rigtorp.com>
Cc: Pavel Machek <pavel@ucw.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040704114920.GA7820@linux.nu>
References: <20040703172843.GA7274@linux.nu>
	 <20040703204647.GE31892@elf.ucw.cz>  <20040704114920.GA7820@linux.nu>
Content-Type: text/plain
Message-Id: <1088981417.2647.1.camel@nigel-laptop.wpcb.org.au>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Mon, 05 Jul 2004 08:50:18 +1000
Content-Transfer-Encoding: 7bit
X-TPG-Antivirus: Passed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Sun, 2004-07-04 at 21:49, Erik Rigtorp wrote:
> That is infact my intention. I've looked some at the swsusp2 code but it
> looks ugly. My plan is to create a general kernel level interface to
> bootsplash, then add hooks in swsusp. This code should probably live in the
> bootsplash patch.

Yes. I'd love a better in kernel interface. Could you make it so that
for an arbitrary vt, we easily detect if bootsplash is on, switch
between silent and verbose and set the progress bar value?

Regards,

Nigel

