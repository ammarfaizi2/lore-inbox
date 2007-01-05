Return-Path: <linux-kernel-owner+w=401wt.eu-S1161097AbXAEODU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161097AbXAEODU (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 09:03:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161099AbXAEODU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 09:03:20 -0500
Received: from xdsl-664.zgora.dialog.net.pl ([81.168.226.152]:4588 "EHLO
	tuxland.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161097AbXAEODT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 09:03:19 -0500
From: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
To: Marcin Juszkiewicz <openembedded@hrw.one.pl>
Subject: Re: [PATCH] backlight control for Frontpath ProGear HX1050+
Date: Fri, 5 Jan 2007 15:03:21 +0100
User-Agent: KMail/1.9.5
Cc: linux-kernel@vger.kernel.org, Alan <alan@lxorguk.ukuu.org.uk>,
       Richard Purdie <rpurdie@rpsys.net>
References: <200701050903.31859.openembedded@hrw.one.pl> <20070105093901.7f2ef1f8@localhost.localdomain> <200701051215.54243.openembedded@hrw.one.pl>
In-Reply-To: <200701051215.54243.openembedded@hrw.one.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701051503.22245.m.kozlowski@tuxland.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Witam Marcin,

Not a big deal.

> +	if (pmu_dev)
> +		pci_dev_put(pmu_dev);
> +
> +	if (sb_dev)
> +		pci_dev_put(sb_dev);

pci_dev_put() can handle NULL argument.

-- 
Pozdrawiam,

	Mariusz Kozlowski
