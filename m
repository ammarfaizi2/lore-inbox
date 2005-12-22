Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964842AbVLVMyk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964842AbVLVMyk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 07:54:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964892AbVLVMyk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 07:54:40 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:17104 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S964842AbVLVMyj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 07:54:39 -0500
Message-ID: <43AAB3C8.DB304856@tv-sign.ru>
Date: Thu, 22 Dec 2005 17:10:16 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Daniel Walker <dwalker@mvista.com>
Cc: mingo@elte.hu, tglx@linutronix.de, inaky.perez-gonzalez@intel.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/02] RT: plist namespace cleanup
References: <1135202230.22970.15.camel@localhost.localdomain>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Walker wrote:
> 
>         Make the plist namespace consistent.

I think plist_head is much better than pl_head.

However I think plist_empty/plist_unhashed is more accurate
than plist_head_empty/plist_node_empty, but I am rather
agnostic to naming.

Ingo, do you have any preferences?

Daniel, it would be great if you can check that kernel/rt.o
was not changed after rename (as it should be).

Oleg.
