Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261246AbTDHJUQ (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 05:20:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261276AbTDHJT0 (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 05:19:26 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:16792
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S261246AbTDHJRV (for <rfc822;linux-kernel@vger.kernel.org>); Tue, 8 Apr 2003 05:17:21 -0400
Subject: Re: 2.4.21-pre7 IDE compilation problems (and previous kernels)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Dan Merillat <dmerillat@sequiam.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030407202024.GH1712@chaos.ao.net>
References: <20030407202024.GH1712@chaos.ao.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1049756278.7271.4.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 07 Apr 2003 23:59:19 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2003-04-07 at 21:20, Dan Merillat wrote:
> DMA is required for a successful compile:  (After make clean/make dep)
> 
> drivers/ide/idedriver.o(.text+0x28c): In function `init_dma_generic':
> : undefined reference to `ide_setup_dma'
> drivers/ide/idedriver.o(.text+0x12e36): In function

I have a fix pending for this from Andries

