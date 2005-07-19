Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261864AbVGSI4n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261864AbVGSI4n (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Jul 2005 04:56:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261892AbVGSI4n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Jul 2005 04:56:43 -0400
Received: from [81.2.110.250] ([81.2.110.250]:32473 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261864AbVGSI4m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Jul 2005 04:56:42 -0400
Subject: Re: ANNOUNCE: Driver for Rocky 4782E WDT and pls help
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Gyorgy Horvath <horvaath@alpha.tmit.bme.hu>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <42DD3CD3.9070508@alpha.tmit.bme.hu>
References: <42DC2871.1030103@alpha.tmit.bme.hu>
	 <1121704467.12438.71.camel@localhost.localdomain>
	 <42DD3CD3.9070508@alpha.tmit.bme.hu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 19 Jul 2005 10:20:40 +0100
Message-Id: <1121764841.22336.14.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2005-07-19 at 10:48 -0700, Gyorgy Horvath wrote:
> !!!!!!!! Alan - YOU KNOW SOMETHING !!!!!!!!!!!!!!
> 
> The system can go without IDE dma for this particular application,
> but it would be better to go with it ...
> 
> Are there any known issues about the chipsets down here?
> Concerning IDE's ultra DMA?

There are not, but I've seen various boxes behave the way you describe
with IDE DMA enabled as IDE DMA uses a lot of the PCI bandwidth. Usually
it indicates a hardware bug and as far as ICH errata are concerned I
know of none relevant. You can check however as Intel put most chipset
errata docs on their website.


