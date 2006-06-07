Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751135AbWFGIvj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751135AbWFGIvj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jun 2006 04:51:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751141AbWFGIvj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jun 2006 04:51:39 -0400
Received: from hobbit.corpit.ru ([81.13.94.6]:81 "EHLO hobbit.corpit.ru")
	by vger.kernel.org with ESMTP id S1751135AbWFGIvj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jun 2006 04:51:39 -0400
Message-ID: <44869397.4000907@tls.msk.ru>
Date: Wed, 07 Jun 2006 12:51:35 +0400
From: Michael Tokarev <mjt@tls.msk.ru>
User-Agent: Mail/News 1.5 (X11/20060318)
MIME-Version: 1.0
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: klibc - another libc?
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After several mentions of klibc recently, I want to ask a question.

I understand all the kernel-mode cleanups -- moving initialization
from kernel to user space is a very good thing.

But the question really is: why yet another libc?  We already have
dietlibc, uclibc, glibc, now klibc...  With modern kernel, initramfs
will very probably contain quite some programs linked with glibc
(modprobe/insmod, mdadm/lvm, etc; I highly suggest putting some
minimal text editor like nvi there too, for rescue purposes) --
so why not have an option to use whatever libc is available on
the host platform?

In the other words, kinit/ipconfig/nfsmount/etc stuff is ok,
no questions.  But the libc itself -- what for?

And another related question: why not dietlibc which is already
here, for quite long time?

Thanks.

/mjt
