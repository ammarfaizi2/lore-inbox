Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270413AbTGMWPJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jul 2003 18:15:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270416AbTGMWPJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jul 2003 18:15:09 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:19947 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S270413AbTGMWPG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jul 2003 18:15:06 -0400
Date: Mon, 14 Jul 2003 00:29:45 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: jgarzik@pobox.com, akpm@digeo.com
Cc: linux-net@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Remove net drivers depending on OBSOLETE
Message-ID: <20030713222945.GC12104@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following three net drivers depend in both 2.4 and 2.5 on 
CONFIG_OBSOLETE:
- FMV18X
- SEEQ8005
- SK_G16

Since CONFIG_OBSOLETE is never set they are not selectable.
Is there any reason why they should stay in the kernel or would you 
accept a patch that removes these drivers?

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

