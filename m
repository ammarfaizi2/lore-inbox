Return-Path: <linux-kernel-owner+w=401wt.eu-S932312AbWLNKoW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932312AbWLNKoW (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 05:44:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932368AbWLNKoW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 05:44:22 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:39357 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S932312AbWLNKoV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 05:44:21 -0500
Date: Thu, 14 Dec 2006 10:52:35 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de
Subject: Re: Userspace I/O driver core
Message-ID: <20061214105235.46c080ae@localhost.localdomain>
In-Reply-To: <20061214010608.GA13229@kroah.com>
References: <20061214010608.GA13229@kroah.com>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> But in order to get this core into the kernel tree, we need to have some
> "real" drivers written that use it.  So, for anyone that wants to see
> this go into the tree, now is the time to step forward and post your
> patches for hardware that this kind of driver interface is needed.

Might be kind of hairy given uio_read() doesn't even return from the
kernel. This code simply isn't fit for purpose, philosophical debate
aside.

Alan
