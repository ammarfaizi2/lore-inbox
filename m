Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261168AbVBLVad@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261168AbVBLVad (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Feb 2005 16:30:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261171AbVBLVad
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Feb 2005 16:30:33 -0500
Received: from math.ut.ee ([193.40.5.125]:12476 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id S261168AbVBLVaR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Feb 2005 16:30:17 -0500
Date: Sat, 12 Feb 2005 23:30:13 +0200 (EET)
From: Meelis Roos <mroos@linux.ee>
To: sam@ravnborg.org, Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: spontaneous rebuilds on prom console tables
Message-ID: <Pine.SOC.4.61.0502122327590.21021@math.ut.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When I run "make" on 2.6 sparc32 macine several times it remakes prom 
console files each time and so links a new kernel.

   CNMKHSH drivers/video/console/promcon_tbl.c
   CC      drivers/video/console/promcon_tbl.o
   LD      drivers/video/console/built-in.o
   LD      drivers/video/built-in.o
   LD      drivers/built-in.o
...

-- 
Meelis Roos (mroos@linux.ee)
