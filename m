Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262070AbVGOXx7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262070AbVGOXx7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Jul 2005 19:53:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262084AbVGOXx7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Jul 2005 19:53:59 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:167 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262070AbVGOXwy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Jul 2005 19:52:54 -0400
Subject: RE: 2.6.9 chrdev_open: serial_core: uart_open
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: karl malbrain <karl@petzent.com>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <NDBBKFNEMLJBNHKPPFILMEAMCEAA.karl@petzent.com>
References: <NDBBKFNEMLJBNHKPPFILMEAMCEAA.karl@petzent.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sat, 16 Jul 2005 01:18:16 +0100
Message-Id: <1121473097.23918.18.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-1) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2005-07-15 at 15:02 -0700, karl malbrain wrote:
> I've since answered part of my question.  Red Hat pulled some code-changes
> from 2.6.10 tty_io.c with the somewhat cryptic comment "fix the trivial
> exploits caused by Rolands controlling tty changes (part 1)" and moved the
> tty_sem ops.
> 
> Do you know if this would be Roland at Red Hat, or a Roland at lkml?

Roland at Red Hat. See the kernel list but 2.6.9 had an interesting hole
where you could crash the system by playing games with setsid and
threaded applications.

RHEL bugs really are best in the RHEL bugzilla, or through your support
contact as a customer. That ensures that the bug is processed promptly
and chased up for you while bugzilla is just for bug collection.

Alan

