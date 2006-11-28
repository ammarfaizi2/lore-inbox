Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935798AbWK1KPo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935798AbWK1KPo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 05:15:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935806AbWK1KPn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 05:15:43 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:58843 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S935798AbWK1KPn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 05:15:43 -0500
Subject: Re: mismatch between default and defconfig LOG_BUF_SHIFT values
From: Arjan van de Ven <arjan@infradead.org>
To: "Robert P. J. Day" <rpjday@mindspring.com>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0611280451010.13481@localhost.localdomain>
References: <Pine.LNX.4.64.0611280451010.13481@localhost.localdomain>
Content-Type: text/plain
Organization: Intel International BV
Date: Tue, 28 Nov 2006 11:15:38 +0100
Message-Id: <1164708938.3276.65.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1 (2.8.1.1-3.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> ...
> 
>   is it worth trying to bring the Kconfig.debug default values into
> line with the defconfig file values, to avoid any possible confusion?

I don't think so. 
defconfig is just there to get some working system. You should really
pay attention to the config options you care about, and select the value
YOU want. Neither defconfig nor the "default value" matter in that.
Of course especially the "default value" should be a sane one, but it is
in this case.. your system boots and works fine.

defconfig also tends to be the config used by the arch maintainer, eg
the one he uses for his system. He might very well have different
preferences than you have...


-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com
Test the interaction between Linux and your BIOS via http://www.linuxfirmwarekit.org

