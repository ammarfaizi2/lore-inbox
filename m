Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267773AbTBXSqp>; Mon, 24 Feb 2003 13:46:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267775AbTBXSqp>; Mon, 24 Feb 2003 13:46:45 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:5248
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267773AbTBXSqo>; Mon, 24 Feb 2003 13:46:44 -0500
Subject: Re: [PATCH] extern in i2o_pci.c
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Maciej Soltysiak <solt@dns.toxicfilms.tv>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.51.0302241934360.7789@dns.toxicfilms.tv>
References: <Pine.LNX.4.51.0302241919050.27815@dns.toxicfilms.tv>
	 <Pine.LNX.4.51.0302241934360.7789@dns.toxicfilms.tv>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1046116683.1256.0.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 24 Feb 2003 19:58:04 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-02-24 at 18:36, Maciej Soltysiak wrote:
> Hi,
> 
> there's a following warning in 2.5.62-bk7:
> 
> drivers/message/i2o/i2o_pci.c: In function `i2o_pci_core_attach':
> drivers/message/i2o/i2o_pci.c:373: warning: implicit declaration of
> function `i2o_sys_init'

Yep.. i2o_pci needs folding into i2o_core. No non PCI i2o ever happened so its
a spare abstraction

