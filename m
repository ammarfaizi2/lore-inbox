Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261568AbUEFR2E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261568AbUEFR2E (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 May 2004 13:28:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261654AbUEFR2E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 May 2004 13:28:04 -0400
Received: from pentafluge.infradead.org ([213.86.99.235]:58822 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261568AbUEFR2A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 May 2004 13:28:00 -0400
Subject: Re: Small problem, Can anybody help me?
From: David Woodhouse <dwmw2@infradead.org>
To: Erik Mouw <erik@harddisk-recovery.com>
Cc: "Srinivas G." <srinivasg@esntechnologies.co.in>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20040506142827.GI15056@harddisk-recovery.com>
References: <1118873EE1755348B4812EA29C55A97222F512@esnmail.esntechnologies.co.in>
	 <20040506142827.GI15056@harddisk-recovery.com>
Content-Type: text/plain
Message-Id: <1083864464.12742.1.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.5.7 (1.5.7-2.dwmw2.1) 
Date: Thu, 06 May 2004 18:27:45 +0100
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-05-06 at 16:28 +0200, Erik Mouw wrote:
> The way to compile a module on linux 2.4 is:
> 
>   gcc -O2 -Wall -I/path/to/kernel/include/directory -D__KERNEL__ -DMODULE -c hello.c

That doesn't always work. It gets the CFLAGS wrong. You should always
use
	make -C $KERNELDIR SUBDIRS=`pwd` modules


-- 
dwmw2

