Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932376AbVIMAKT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932376AbVIMAKT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 20:10:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932382AbVIMAKT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 20:10:19 -0400
Received: from smtp.osdl.org ([65.172.181.4]:12210 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932376AbVIMAKR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 20:10:17 -0400
Date: Mon, 12 Sep 2005 17:10:18 -0700
From: Andrew Morton <akpm@osdl.org>
To: Lion Vollnhals <lion.vollnhals@web.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: drivers/usb/class/bluetty.c does NOT build
Message-Id: <20050912171018.6d97a9d3.akpm@osdl.org>
In-Reply-To: <200509130202.57093.lion.vollnhals@web.de>
References: <20050912024350.60e89eb1.akpm@osdl.org>
	<200509130202.57093.lion.vollnhals@web.de>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lion Vollnhals <lion.vollnhals@web.de> wrote:
>
> I suggest alan's tty fixes are at fault.
>

Yes, the conversion is far from complete.  For now, you'll need to disable
that driver in config, sorry.  Or fix it ;)

