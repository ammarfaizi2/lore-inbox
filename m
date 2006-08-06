Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750719AbWHFVaz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750719AbWHFVaz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Aug 2006 17:30:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750717AbWHFVaz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Aug 2006 17:30:55 -0400
Received: from 85.8.24.16.se.wasadata.net ([85.8.24.16]:1670 "EHLO
	smtp.drzeus.cx") by vger.kernel.org with ESMTP id S1750723AbWHFVay
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Aug 2006 17:30:54 -0400
Message-ID: <44D65F8C.6040603@drzeus.cx>
Date: Sun, 06 Aug 2006 23:30:52 +0200
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: "Randy.Dunlap" <rdunlap@xenotime.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [MMC] Fix base address configuration in wbsd
References: <20060806202223.13663.66134.stgit@poseidon.drzeus.cx>	<20060806204842.GE16816@flint.arm.linux.org.uk>	<44D657BF.6070004@drzeus.cx> <20060806141310.607a6e40.rdunlap@xenotime.net>
In-Reply-To: <20060806141310.607a6e40.rdunlap@xenotime.net>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy.Dunlap wrote:
> and why not <resource_size_t> ?
>
>   

It would still need some casting someplace since we need to stuff the
address into two 8-bit fields when configuring the chip.

Rgds
Pierre

