Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267705AbTHJNwC (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Aug 2003 09:52:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267724AbTHJNwC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Aug 2003 09:52:02 -0400
Received: from duck.doc.ic.ac.uk ([146.169.1.46]:22025 "EHLO duck.doc.ic.ac.uk")
	by vger.kernel.org with ESMTP id S267705AbTHJNwA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Aug 2003 09:52:00 -0400
Date: Sun, 10 Aug 2003 14:51:59 +0100
From: Adam Langley <agl@imperialviolet.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.0-test3 compile failure
Message-ID: <20030810135159.GA29034@linuxpower.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
X-Mailer: Why do *you* want to know??
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/built-in.o(.text+0x65698): In function `atkbd_interrupt':
: undefined reference to `serio_rescan'
drivers/built-in.o(.text+0x65da3): In function `atkbd_disconnect':
: undefined reference to `serio_close'
drivers/built-in.o(.text+0x65ec8): In function `atkbd_connect':
: undefined reference to `serio_open'
drivers/built-in.o(.text+0x66074): In function `atkbd_connect':
: undefined reference to `serio_close'
drivers/built-in.o(.init.text+0x97ae): In function `atkbd_init':
: undefined reference to `serio_register_device'
drivers/built-in.o(.exit.text+0x69e): In function `atkbd_exit':
: undefined reference to `serio_unregister_device'
make: *** [.tmp_vmlinux1] Error 1

.config file is at http://www2.doc.ic.ac.uk/~agl02/2.6.0-test3-config

-- 
Adam Langley                                      agl@imperialviolet.org
http://www.imperialviolet.org                       (+44) (0)7906 332512
PGP: 9113   256A   CC0F   71A6   4C84   5087   CDA5   52DF   2CB6   3D60
