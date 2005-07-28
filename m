Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261525AbVG1PGM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261525AbVG1PGM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 11:06:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261546AbVG1PGI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 11:06:08 -0400
Received: from mail.thorsten-knabe.de ([82.141.44.28]:16904 "EHLO
	mail.thorsten-knabe.de") by vger.kernel.org with ESMTP
	id S261525AbVG1PEV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 11:04:21 -0400
Date: Thu, 28 Jul 2005 17:04:20 +0200 (CEST)
From: Thorsten Knabe <linux@thorsten-knabe.de>
X-X-Sender: tek@tek01.intern.thorsten-knabe.de
To: Adrian Bunk <bunk@stusta.de>
cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
       linux-sound@vger.kernel.org
Subject: Re: [2.6 patch] schedule obsolete OSS drivers for removal
In-Reply-To: <20050726150837.GT3160@stusta.de>
Message-ID: <Pine.LNX.4.61.0507281636040.20815@tek01.intern.thorsten-knabe.de>
References: <20050726150837.GT3160@stusta.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-Spam-Report: SpamAssassin@thorsten-knabe.de
	Content analysis details:   (-5.9 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Jul 2005, Adrian Bunk wrote:

> This patch schedules obsolete OSS drivers (with ALSA drivers that
> support the same hardware) for removal.

Hello Adrian.

I'm the maintainer of the OSS AD1816 sound driver. I'm aware of two 
problems of the ALSA AD1816 driver, that do not show up with the OSS 
driver:
- According to my own experience and user reports audio is choppy with 
some VoIP Softphones like gnophone at least when used with the ALSA OSS 
emulation layer, whereas the OSS driver is crystal clear.
- Users reported, that on some HP Kayak systems the on-board AD1816A 
was not properly detected by the ALSA driver or was detected, but 
there was no audio output. I'm not sure if the problem is still present in 
the current ALSA driver, as I do not own such a system.

Maybe the OSS driver should stay in the kernel, until those problems are 
fixed in the ALSA driver.

Regards
Thorsten

-- 
___
  |        | /                 E-Mail: linux@thorsten-knabe.de
  |horsten |/\nabe                WWW: http://linux.thorsten-knabe.de
