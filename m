Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261820AbUKUWCy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261820AbUKUWCy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Nov 2004 17:02:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261821AbUKUWCy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Nov 2004 17:02:54 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:17679 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261820AbUKUWCx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Nov 2004 17:02:53 -0500
Date: Sun, 21 Nov 2004 23:02:51 +0100
From: Adrian Bunk <bunk@stusta.de>
To: johnpol@2ka.mipt.ru
Cc: sensors@stimpy.netroedge.com, linux-kernel@vger.kernel.org
Subject: drivers/w1/: why is dscore.c not ds9490r.c ?
Message-ID: <20041121220251.GE13254@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Evgeniy,

drivers/w1/Makefile in recent 2.6 kernels contains:
  obj-$(CONFIG_W1_DS9490)         += ds9490r.o 
  ds9490r-objs    := dscore.o

Is there a reason, why dscore.c isn't simply named ds9490r.c ?

TIA
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

