Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265525AbUABMkk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jan 2004 07:40:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265526AbUABMkk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jan 2004 07:40:40 -0500
Received: from moutng.kundenserver.de ([212.227.126.188]:3036 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S265525AbUABMkj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jan 2004 07:40:39 -0500
From: Steffen Weber <email@steffenweber.net>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-rc1-mm1
Date: Fri, 2 Jan 2004 13:40:37 +0100
User-Agent: KMail/1.5.94
References: <20031231004725.535a89e4.akpm@osdl.org>
In-Reply-To: <20031231004725.535a89e4.akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200401021340.37935.email@steffenweber.net>
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:b209696183274129cae07c90a67bd885
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm getting the following error with 2.6.0-rc1-mm1, which does not occur with 
2.6.0-rc1:

  CC      drivers/net/8139too.o
drivers/net/8139too.c: In function `rtl8139_open':
drivers/net/8139too.c:1326: error: `CONFIG_8139_RXBUF_IDX' undeclared (first 
use in this function)
drivers/net/8139too.c:1326: error: (Each undeclared identifier is reported 
only once
drivers/net/8139too.c:1326: error: for each function it appears in.)
drivers/net/8139too.c: In function `rtl8139_rx':
drivers/net/8139too.c:1943: error: `CONFIG_8139_RXBUF_IDX' undeclared (first 
use in this function)
drivers/net/8139too.c: In function `rtl8139_close':
drivers/net/8139too.c:2248: error: `CONFIG_8139_RXBUF_IDX' undeclared (first 
use in this function)
make[2]: *** [drivers/net/8139too.o] Error 1
make[1]: *** [drivers/net] Error 2
make: *** [drivers] Error 2

Steffen
