Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751270AbWGKMxA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751270AbWGKMxA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 08:53:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751274AbWGKMw7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 08:52:59 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:46097 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751270AbWGKMw7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 08:52:59 -0400
Date: Tue, 11 Jul 2006 14:52:58 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, Alan Cox <alan@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: 2.6.18-rc1-mm1: drivers/ide/pci/jmicron.c warning
Message-ID: <20060711125258.GN13938@stusta.de>
References: <20060709021106.9310d4d1.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060709021106.9310d4d1.akpm@osdl.org>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

gcc gives the following warning:

<--  snip  -->

...
  CC      drivers/ide/pci/jmicron.o
drivers/ide/pci/jmicron.c: In function ‘ata66_jmicron’:
drivers/ide/pci/jmicron.c:99: warning: control reaches end of non-void function
...

<--  snip  -->

At least from gcc's perspective, this warning is correct, and it should 
therefore be fixed.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

