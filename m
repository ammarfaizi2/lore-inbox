Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261924AbVGZQ3O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261924AbVGZQ3O (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 12:29:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261947AbVGZQ1R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 12:27:17 -0400
Received: from tetsuo.zabbo.net ([207.173.201.20]:50156 "EHLO tetsuo.zabbo.net")
	by vger.kernel.org with ESMTP id S261942AbVGZQ1E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 12:27:04 -0400
Message-ID: <42E6645B.30206@zabbo.net>
Date: Tue, 26 Jul 2005 09:27:07 -0700
From: Zach Brown <zab@zabbo.net>
User-Agent: Mozilla Thunderbird 1.0.2-1.3.3 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org, perex@suse.cz, alsa-devel@alsa-project.org,
       James@superbug.demon.co.uk, sailer@ife.ee.ethz.ch,
       linux-sound@vger.kernel.org, kyle@parisc-linux.org,
       parisc-linux@lists.parisc-linux.org, jgarzik@pobox.com,
       Thorsten Knabe <linux@thorsten-knabe.de>, zwane@commfireservices.com,
       zaitcev@yahoo.com
Subject: Re: [2.6 patch] schedule obsolete OSS drivers for removal
References: <20050726150837.GT3160@stusta.de>
In-Reply-To: <20050726150837.GT3160@stusta.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> This patch schedules obsolete OSS drivers (with ALSA drivers that 
> support the same hardware) for removal.

> I've Cc'ed the people listed in MAINTAINERS as being responsible for one 
> or more of these drivers, and I've also Cc'ed the ALSA people.

I haven't touched the maestro drivers in so long (for near-total lack of
docs, etc.) that I can't be considered authoritative for approving it's
removal.  If people are relying on it I certainly don't know who they
are.  In better news, Takashi should now have the pile of maestro
hardware that I used in the first pass to help him maintain the ALSA
driver..

- z
