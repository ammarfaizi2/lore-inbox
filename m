Return-Path: <linux-kernel-owner+w=401wt.eu-S965034AbXAJTCo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965034AbXAJTCo (ORCPT <rfc822;w@1wt.eu>);
	Wed, 10 Jan 2007 14:02:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965033AbXAJTCn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Jan 2007 14:02:43 -0500
Received: from 85.8.24.16.se.wasadata.net ([85.8.24.16]:40405 "EHLO
	smtp.drzeus.cx" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965031AbXAJTCn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Jan 2007 14:02:43 -0500
Message-ID: <45A53856.7060209@drzeus.cx>
Date: Wed, 10 Jan 2007 20:02:46 +0100
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Thunderbird 1.5.0.9 (X11/20061223)
MIME-Version: 1.0
To: Pavel Pisa <ppisa@pikron.com>
CC: Philip Langdale <philipl@overt.org>, linux-kernel@vger.kernel.org,
       Alex Dubov <oakad@yahoo.com>, Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH 2.6.19] mmc: Fix handling of response types in imxmmc
 and tifm drivers
References: <459D178F.8000607@overt.org> <200701071834.22893.ppisa@pikron.com>
In-Reply-To: <200701071834.22893.ppisa@pikron.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Pisa wrote:
> I have tested your patch.
> Kernel builds. I have not found much time for testing.
> But I would not like to block changes and I am going
> for next week to project meeting in Spain, so there is
> my reply.
>
> I have 2.6.19 + realtime-patches rt14 on the hand.
> I have been able to mount and use some cards, but it
> I have observed some problems probably related to timing
> when I have tried to change CPU frequency.
>
>   

>From what I gather, the imx driver/hw is a bit funky in several areas.

My plan with this patch is -mm for this release, and merged during the next.

Rgds

-- 
     -- Pierre Ossman

  Linux kernel, MMC maintainer        http://www.kernel.org
  PulseAudio, core developer          http://pulseaudio.org
  rdesktop, core developer          http://www.rdesktop.org

