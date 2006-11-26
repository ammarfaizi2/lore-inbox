Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757962AbWKZUZN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757962AbWKZUZN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Nov 2006 15:25:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757966AbWKZUZN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Nov 2006 15:25:13 -0500
Received: from 85.8.24.16.se.wasadata.net ([85.8.24.16]:47767 "EHLO
	smtp.drzeus.cx") by vger.kernel.org with ESMTP id S1757962AbWKZUZL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Nov 2006 15:25:11 -0500
Message-ID: <4569F82E.1040207@drzeus.cx>
Date: Sun, 26 Nov 2006 21:25:18 +0100
From: Pierre Ossman <drzeus-mmc@drzeus.cx>
User-Agent: Thunderbird 1.5.0.7 (X11/20061027)
MIME-Version: 1.0
To: Vitaly Wool <vitalywool@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix "prev->state: 2 != TASK_RUNNING??" problem on SD/MMC
 card removal
References: <20061123184217.a971d267.vitalywool@gmail.com>
In-Reply-To: <20061123184217.a971d267.vitalywool@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vitaly Wool wrote:
> Hello Pierre,
> 
> currently on SD/MMC card removal the system exhibits the following message (the platform is ARM Versatile):
> 
>     prev->state: 2 != TASK_RUNNING??
>     mmcqd/762[CPU#0]: BUG in __schedule at linux-2.6/kernel/sched.c:3826
> 

Hmm... I can't find any such requirement in HEAD, or 2.6.18. What kernel
are you running?

Rgds
-- 
     -- Pierre Ossman

  Linux kernel, MMC maintainer        http://www.kernel.org
  PulseAudio, core developer          http://pulseaudio.org
  rdesktop, core developer          http://www.rdesktop.org
