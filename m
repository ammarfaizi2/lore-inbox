Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932195AbWEGQmu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932195AbWEGQmu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 May 2006 12:42:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932196AbWEGQmu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 May 2006 12:42:50 -0400
Received: from mail.gmx.de ([213.165.64.20]:16588 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932195AbWEGQmu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 May 2006 12:42:50 -0400
X-Authenticated: #20450766
Date: Sun, 7 May 2006 18:42:51 +0200 (CEST)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: power management processor on y ttyS - new line disciplin?
Message-ID: <Pine.LNX.4.60.0605071838300.3555@poirot.grange>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On an embedded system (kurobox from Buffalo) they connected a 
power-management controller to ttyS0. Among basic functions you have to 
write some byte sequence to it to disable the watchdog, then you have to 
write some stuff to it to switch power off / reboot. You also get power- 
and reset-button events from it. The buttons one would connect as input. 
but the power management? Is it a case for a new line discipline? Are 
there other examples of similar designs?

Thanks
Guennadi
---
Guennadi Liakhovetski
