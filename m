Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132434AbRDWJyg>; Mon, 23 Apr 2001 05:54:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132589AbRDWJyS>; Mon, 23 Apr 2001 05:54:18 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:20740 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S132434AbRDWJyJ>; Mon, 23 Apr 2001 05:54:09 -0400
Subject: Re: disable_ide_dma gcc-3.0 warn
To: jamagallon@able.es (J . A . Magallon)
Date: Mon, 23 Apr 2001 10:55:58 +0100 (BST)
Cc: linux-kernel@vger.kernel.org (Linux Kernel),
        alan@lxorguk.ukuu.org.uk (Alan Cox)
In-Reply-To: <20010423110753.A25081@werewolf.able.es> from "J . A . Magallon" at Apr 23, 2001 11:07:53 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14rd4b-0007hJ-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> -march=i686    -c -o dmi_scan.o dmi_scan.c
> dmi_scan.c:158: warning: `disable_ide_dma' defined but not used
> 
> In dmi_scan.c there is the func:
> static __init int disable_ide_dma(struct dmi_blacklist *d)
> 
> But now it is unused (intentionally ?):

Intentionally for now
