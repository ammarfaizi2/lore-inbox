Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750888AbWAYAPY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750888AbWAYAPY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jan 2006 19:15:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750889AbWAYAPY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jan 2006 19:15:24 -0500
Received: from smtp.osdl.org ([65.172.181.4]:10718 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750887AbWAYAPX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jan 2006 19:15:23 -0500
Date: Tue, 24 Jan 2006 16:17:14 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: pavel@ucw.cz, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -mm] swsusp: userland interface (rev 2)
Message-Id: <20060124161714.0118f1af.akpm@osdl.org>
In-Reply-To: <200601250053.27394.rjw@sisk.pl>
References: <200601240929.37676.rjw@sisk.pl>
	<20060124135843.739481e7.akpm@osdl.org>
	<20060124221426.GB1602@elf.ucw.cz>
	<200601250053.27394.rjw@sisk.pl>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Rafael J. Wysocki" <rjw@sisk.pl> wrote:
>
> IMHO after it gets into mainline every next version of the interface should
> be backwards compatible with the previous one.

That's insufficient.  Every new version of the userspace tools also needs
to be back-compatible with (and tested against!) older kernels.

Otherwise, people who upgrade both their kernel and userspace will find
that their old kernels don't work right, so they have to downgrade their
userspace tools too.

