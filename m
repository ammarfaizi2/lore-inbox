Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263373AbVGPItb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263373AbVGPItb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Jul 2005 04:49:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262245AbVGPIqz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Jul 2005 04:46:55 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:59308 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261944AbVGPIpS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Jul 2005 04:45:18 -0400
Date: Sat, 16 Jul 2005 10:45:17 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Module option for compiled-in parts
Message-ID: <Pine.LNX.4.61.0507161043470.5993@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


I have added a module_param() to a component that is compiled in
(drivers/char/vt.c). Since it's not a module, will it still show a 
/sys/module/WhatGoesHere/parameters/myvariablename file? What will be put as 
"WhatGoesHere" as vt.c does not become vt.ko?


Jan Engelhardt
-- 
