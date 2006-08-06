Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750712AbWHFV3w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750712AbWHFV3w (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Aug 2006 17:29:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750717AbWHFV3w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Aug 2006 17:29:52 -0400
Received: from 85.8.24.16.se.wasadata.net ([85.8.24.16]:1158 "EHLO
	smtp.drzeus.cx") by vger.kernel.org with ESMTP id S1750712AbWHFV3v
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Aug 2006 17:29:51 -0400
Message-ID: <44D65F4D.3060907@drzeus.cx>
Date: Sun, 06 Aug 2006 23:29:49 +0200
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [MMC] Fix base address configuration in wbsd
References: <20060806202223.13663.66134.stgit@poseidon.drzeus.cx> <20060806204842.GE16816@flint.arm.linux.org.uk> <44D657BF.6070004@drzeus.cx> <20060806210509.GF16816@flint.arm.linux.org.uk>
In-Reply-To: <20060806210509.GF16816@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> Is that a safe assumption to make?  Is this only ever going to appear/be
> used on x86?
>
>   

It's designed for ISA, so I think so. In the event that a version of
this model appears that has a larger I/O base, then the configure
registers will have been reordered (to make room for any extra address
bytes), so the driver will not work out-of-box anyway.

Rgds
Pierre

