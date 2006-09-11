Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750739AbWIKKRr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750739AbWIKKRr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 06:17:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750752AbWIKKRr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 06:17:47 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:11998 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1750739AbWIKKRq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 06:17:46 -0400
Subject: Re: missing request_region in pnpbios_probe_system
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Olaf Hering <olaf@aepfle.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060911095759.GA23339@aepfle.de>
References: <20060911095759.GA23339@aepfle.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 11 Sep 2006 11:41:03 +0100
Message-Id: <1157971263.23085.123.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Llu, 2006-09-11 am 11:57 +0200, ysgrifennodd Olaf Hering:
> Does anyone know why pnpbios_probe_system() does no request_region()
> before it reads from 0xf0000 to 0xffff0?

It's the system ROM. It's not a private resource.

