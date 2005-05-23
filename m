Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261533AbVEWNmG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261533AbVEWNmG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 May 2005 09:42:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261613AbVEWNmG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 May 2005 09:42:06 -0400
Received: from zenon.apartia.fr ([82.66.93.83]:63946 "EHLO zenon.apartia.org")
	by vger.kernel.org with ESMTP id S261533AbVEWNmC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 May 2005 09:42:02 -0400
Message-ID: <4291DDA5.3070706@apartia.fr>
Date: Mon, 23 May 2005 15:41:57 +0200
From: Laurent CARON <lcaron@apartia.fr>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: linux-kernel-Mailing-list <linux-kernel@vger.kernel.org>
Subject: New revision of promise TX4
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I recently bought a TX-4 which seems to be using a new chip (PCI ID: 
105A:3519).

It was not supported by the kernel so i added those lines to promise_sata.c

diff sata_promise.c /usr/src/linux-2.6.11.9/drivers/scsi/sata_promise.c
170,171d169
<       { PCI_VENDOR_ID_PROMISE, 0x3519, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
<         board_20319 },


Is it the 'right' way?

Thanks

Laurent
