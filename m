Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750727AbVKZUII@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750727AbVKZUII (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Nov 2005 15:08:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750729AbVKZUII
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Nov 2005 15:08:08 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:25739 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1750727AbVKZUIG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Nov 2005 15:08:06 -0500
Date: Sat, 26 Nov 2005 21:08:07 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: mousedev parametes not visible in /sys
Message-ID: <Pine.LNX.4.61.0511262102390.17231@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,


linux-2.6.13/drivers/input/mousedev.c has some module_params, but they do 
not show up in /sys, i.e. there is no /sys/modules/mousedev directory at 
all. Even though it is a compiled-in 'module', I do know that even 
compiled-ins can get a directory under /sys/modules/, as is the case with 
a module_param in e.g. drivers/char/vt.c which shows as /sys/modules/vt.

Can anybody confirm this or know what's wrong?



Jan Engelhardt
-- 
