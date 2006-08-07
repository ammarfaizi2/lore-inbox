Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932200AbWHGQRU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932200AbWHGQRU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 12:17:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932203AbWHGQRU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 12:17:20 -0400
Received: from mail.suse.de ([195.135.220.2]:17832 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932200AbWHGQRU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 12:17:20 -0400
From: Andi Kleen <ak@suse.de>
To: "Protasevich, Natalie" <Natalie.Protasevich@unisys.com>
Subject: Re: [PATCH] x86_64: Make NR_IRQS configurable in Kconfig
Date: Mon, 7 Aug 2006 18:17:13 +0200
User-Agent: KMail/1.9.3
Cc: "Randy.Dunlap" <rdunlap@xenotime.net>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       "Andrew Morton" <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <19D0D50E9B1D0A40A9F0323DBFA04ACC023B0C86@USRV-EXCH4.na.uis.unisys.com>
In-Reply-To: <19D0D50E9B1D0A40A9F0323DBFA04ACC023B0C86@USRV-EXCH4.na.uis.unisys.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608071817.13318.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 4k being a humble maximum is definitely a relative term here, but on the
> system with "only" 64 or 128 processors the cpu*224 would be much higher
> :) However, maybe CONFIG_TINY that Andi suggested would leverage this
> number also. What do you think, Eric?

Best would be something dynamic - kernels should be self tuning, not 
require that much CONFIG magic.

Just PCI hotplug gives me headaches with this.

Maybe we just need growable per CPU data.

-Andi
