Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964773AbWGML0M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964773AbWGML0M (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 07:26:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932476AbWGML0L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 07:26:11 -0400
Received: from lx-ltd.ru ([85.113.143.174]:30609 "EHLO iserver.lx.intercon.ru")
	by vger.kernel.org with ESMTP id S932491AbWGML0K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 07:26:10 -0400
To: linux-kernel@vger.kernel.org
Subject: Bugs in usb-skeleton.c??? :)
From: Sergej Pupykin <ps@lx-ltd.ru>
Date: 13 Jul 2006 15:26:07 +0400
Message-ID: <m3odvtvj8w.fsf@lx-ltd.ru>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello, All!

As I understand, USB subsystem uses urb->transfer_buffer directly with
DMA. I see that usb-skeleton.c and (at least) bluez's hci_usb allocates it
without GFP_DMA flag. (skeleton with GFP_KERNEL, bluez with GFP_ATOMIC)

(checked versions are 2.4.32 and 2.6.17, ohci only)

Please advise.

