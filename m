Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965196AbWFALp2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965196AbWFALp2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 07:45:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750879AbWFALp2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 07:45:28 -0400
Received: from embla.aitel.hist.no ([158.38.50.22]:41662 "HELO
	embla.aitel.hist.no") by vger.kernel.org with SMTP id S1750859AbWFALp1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 07:45:27 -0400
Message-ID: <447ED2AB.30107@aitel.hist.no>
Date: Thu, 01 Jun 2006 13:42:35 +0200
From: Helge Hafting <helge.hafting@aitel.hist.no>
User-Agent: Thunderbird 1.5.0.2 (X11/20060516)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-rc5-mm2 another compile error
References: <20060601014806.e86b3cc0.akpm@osdl.org>
In-Reply-To: <20060601014806.e86b3cc0.akpm@osdl.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  CC      drivers/dma/ioatdma.o
drivers/dma/ioatdma.c: In function ‘ioat_init_module’:
drivers/dma/ioatdma.c:828: error: dereferencing pointer to incomplete type
make[2]: *** [drivers/dma/ioatdma.o] Error 1
make[1]: *** [drivers/dma] Error 2
make: *** [drivers] Error 2

Now recompiling without support for "DMA engines"

Helge Hafting
