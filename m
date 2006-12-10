Return-Path: <linux-kernel-owner+w=401wt.eu-S1762617AbWLJVSs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762617AbWLJVSs (ORCPT <rfc822;w@1wt.eu>);
	Sun, 10 Dec 2006 16:18:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762616AbWLJVSs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Dec 2006 16:18:48 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:45555 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1762617AbWLJVSr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Dec 2006 16:18:47 -0500
Date: Sun, 10 Dec 2006 21:26:40 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: dcarpenter <error27@gmail.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [patch] tty_io.c balance tty_ldisc_ref()
Message-ID: <20061210212640.22b436e6@localhost.localdomain>
In-Reply-To: <20061210205655.GA4062@localhost.localdomain>
References: <20061210205655.GA4062@localhost.localdomain>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 10 Dec 2006 12:56:55 -0800
dcarpenter <error27@gmail.com> wrote:

> tty_ldisc_deref() should only be called when 
> tty_ldisc_ref() succeeds otherwise it triggers a BUG().
> There's already a function tty_ldisc_flush() that flushes
> properly.

Well spotted and nicely fixed.
> 
> Signed-off-by: Dan Carpenter <error27@gmail.com>

Acked-by: Alan Cox <alan@redhat.com>
