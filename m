Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261775AbVEUTHI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261775AbVEUTHI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 May 2005 15:07:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261773AbVEUTHH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 May 2005 15:07:07 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:17372 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261775AbVEUTGz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 May 2005 15:06:55 -0400
Date: Sat, 21 May 2005 21:06:50 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: route procfile problems
Message-ID: <Pine.LNX.4.61.0505212105100.28358@yvahk01.tjqt.qr>
X-Copyright: "Copyright (C) by Jan Engelhardt. All Rights Reserved."
X-Notice: "Duplication, redistribution and involvement of third parties is not permitted without prior written permission."
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello list,



the following commands all "work":

	cat /proc/net/route | while read line; echo $line; done

	cat /proc/net/dev | while read line; echo $line; done

	while read line; echo $line; done </proc/net/dev;

The one that does not work is:

	while read line; echo $line; done </proc/net/route;

which only returns one line. Does anybody know what is causing this?

(Please CC, as I am not currently on the list.)


Regards,
Jan Engelhardt
-- 
