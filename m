Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265944AbUGVNyp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265944AbUGVNyp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jul 2004 09:54:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265812AbUGVNyo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jul 2004 09:54:44 -0400
Received: from mproxy.gmail.com ([216.239.56.251]:11030 "HELO mproxy.gmail.com")
	by vger.kernel.org with SMTP id S265946AbUGVNyo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jul 2004 09:54:44 -0400
Message-ID: <85ea7b2204072206544edca8d8@mail.gmail.com>
Date: Thu, 22 Jul 2004 19:24:43 +0530
From: pavan <linux.mail@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: COW callback
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i am very new to linux kernel world. so please excuse me for any
trivial queries. but i am looking for some callback/signal mechanism
so that the driver is notified when a page is COWed (in
handle_pte_fault).

i have wriiten a simple driver which support mmap. i want to keep
track of the modified pages so that when the user calls msync (but
does not explicitely provide the start offset and lenght), the
modified pages are flushed to disk. now, is there a mechanism to do
that in 2.4 and onward ?

thanks,
pavan
