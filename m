Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751617AbWIYW5L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751617AbWIYW5L (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 18:57:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751619AbWIYW5L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 18:57:11 -0400
Received: from h-66-166-126-70.lsanca54.covad.net ([66.166.126.70]:54999 "EHLO
	myri.com") by vger.kernel.org with ESMTP id S1751617AbWIYW5H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 18:57:07 -0400
Message-ID: <45185EB0.90300@ens-lyon.org>
Date: Mon, 25 Sep 2006 18:56:48 -0400
From: Brice Goglin <Brice.Goglin@ens-lyon.org>
User-Agent: Thunderbird 1.5.0.5 (X11/20060812)
MIME-Version: 1.0
To: Holger Kiehl <Holger.Kiehl@dwd.de>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Question regarding CONFIG_DMA_ENGINE
References: <Pine.LNX.4.64.0609211249160.9397@diagnostix.dwd.de>
In-Reply-To: <Pine.LNX.4.64.0609211249160.9397@diagnostix.dwd.de>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Holger Kiehl wrote:
> Hello
>
> Is setting this option and CONFIG_NET_DMA usefull even when you do not
> have
> the hardware?
>
> And what hardware is required for this? Is this DMA engine located on
> the network or raid card, or is this something in the chipset? Which
> chipset or cards do have such an engine?
>
> Thanks,
> Holger

I guess the option is completely useless without such hardware.

For now, you need a Intel E5000 chipset (Blackford and co.). It exports
a special PCI device (id 8086:1a38) for DMA. No other device is
supported so far, but some Raid stuff have been proposed recently IIRC.

Brice

