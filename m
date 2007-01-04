Return-Path: <linux-kernel-owner+w=401wt.eu-S932291AbXADF7B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932291AbXADF7B (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 00:59:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932289AbXADF7B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 00:59:01 -0500
Received: from 85.8.24.16.se.wasadata.net ([85.8.24.16]:40169 "EHLO
	smtp.drzeus.cx" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932291AbXADF7A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 00:59:00 -0500
Message-ID: <459C97A9.3060907@drzeus.cx>
Date: Thu, 04 Jan 2007 06:59:05 +0100
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Thunderbird 1.5.0.9 (X11/20061223)
MIME-Version: 1.0
To: Philip Langdale <philipl@overt.org>
CC: Alex Dubov <oakad@yahoo.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.19] mmc: Add support for SDHC cards (Take 2)
References: <459928F3.9010804@overt.org> <20070103150620.ac733abb.akpm@osdl.org> <459C8FA4.7080709@overt.org>
In-Reply-To: <459C8FA4.7080709@overt.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Philip Langdale wrote:
> This is a bug. The MMC_RSP_R? #defines do not fully characterise the
> responses (specically, the way that the response is parsed is not
> characterised) and consequently there is no guarantee of uniqueness.
> Given this reality - the way that the tifm_sd driver works is unsafe.
>
>   

Amen to that. All hw vendors that implement this particular form of
brain damage should be dragged out and shot.

I'll fix a patch for this later on.

Rgds

-- 
     -- Pierre Ossman

  Linux kernel, MMC maintainer        http://www.kernel.org
  PulseAudio, core developer          http://pulseaudio.org
  rdesktop, core developer          http://www.rdesktop.org

