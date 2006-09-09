Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751281AbWIIO4a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751281AbWIIO4a (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Sep 2006 10:56:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751320AbWIIO4a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Sep 2006 10:56:30 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:62177 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751281AbWIIO4a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Sep 2006 10:56:30 -0400
Subject: Re: [PATCH] request_firmware_examples
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Victor Hugo <victor@vhugo.net>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, jonathan@jonmasters.org,
       greg@kroah.com, marcel@holtmann.org
In-Reply-To: <4500AA79.10400@vhugo.net>
References: <4500AA79.10400@vhugo.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sat, 09 Sep 2006 16:19:16 +0100
Message-Id: <1157815156.6877.38.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Iau, 2006-09-07 am 16:25 -0700, ysgrifennodd Victor Hugo:
> +       u8 *buf = kmalloc(size + 1, GFP_KERNEL);
> +       memcpy(buf, firmware, size);

NAK. Out of memory check please.

