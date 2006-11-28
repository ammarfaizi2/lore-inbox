Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757565AbWK1WQf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757565AbWK1WQf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 17:16:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757574AbWK1WQf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 17:16:35 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:41349 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1757565AbWK1WQe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 17:16:34 -0500
Subject: Re: [RFC: 2.6 patch] remove the broken MTD_PCMCIA driver
From: David Woodhouse <dwmw2@infradead.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: Simon Evans <spse@secret.org.uk>, linux-pcmcia@lists.infradead.org,
       linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20061118214056.GB31879@stusta.de>
References: <20061118214056.GB31879@stusta.de>
Content-Type: text/plain
Date: Tue, 28 Nov 2006 22:16:27 +0000
Message-Id: <1164752187.14595.20.camel@pmac.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-2.fc6.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-11-18 at 22:40 +0100, Adrian Bunk wrote:
> The MTD_PCMCIA driver has:
> - already been marked as BROKEN in 2.6.0 three years ago and
> - is still marked as BROKEN.
> 
> Drivers that had been marked as BROKEN for such a long time seem to be
> unlikely to be revived in the forseeable future.

Actually, there's hardware currently on its way to me, and I plan to fix
this driver fairly soon.

> But if anyone wants to ever revive this driver, the code is still
> present in the older kernel releases.

I'm unconvinced by that argument in the general case. People don't go
looking back through git history, do they? Drivers such as this don't
really do any harm as they are, and they're _much_ easier to find when
someone does want to fix them up.

-- 
dwmw2

