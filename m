Return-Path: <linux-kernel-owner+w=401wt.eu-S932130AbXACVF7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932130AbXACVF7 (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 16:05:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932131AbXACVF7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 16:05:59 -0500
Received: from 85.8.24.16.se.wasadata.net ([85.8.24.16]:40144 "EHLO
	smtp.drzeus.cx" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932127AbXACVF4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 16:05:56 -0500
Message-ID: <459C1AB7.9070901@drzeus.cx>
Date: Wed, 03 Jan 2007 22:05:59 +0100
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Thunderbird 1.5.0.9 (X11/20061223)
MIME-Version: 1.0
To: Philip Langdale <philipl@overt.org>
CC: linux-kernel@vger.kernel.org, John Gilmore <gnu@toad.com>
Subject: Re: [PATCH 2.6.19] mmc: Add support for SDHC cards
References: <458C22C0.1080307@vmware.com> <4597A327.8030408@drzeus.cx> <459926B5.60505@overt.org>
In-Reply-To: <459926B5.60505@overt.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Philip Langdale wrote:
> Heh. I forget that you don't want to manually alter the email. Will do.
>
>   

I'm rather reluctant to change anything once someone has put a
signed-off-by line to it. Different people have different limits as to
what they regard a trivial modification.

> Done. I thought we needed it before both SD_APP_SEND_OP_COND calls but
> it's only needed before the second one so I've moved it inline into
> mmc_setup.
>
>   

The spec says we need it at both (even though it might not be so in
practice). We should follow the spec first and foremost.

Rgds

-- 
     -- Pierre Ossman

  Linux kernel, MMC maintainer        http://www.kernel.org
  PulseAudio, core developer          http://pulseaudio.org
  rdesktop, core developer          http://www.rdesktop.org

