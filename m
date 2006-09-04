Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964820AbWIDMSL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964820AbWIDMSL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 08:18:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964829AbWIDMSL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 08:18:11 -0400
Received: from khc.piap.pl ([195.187.100.11]:42966 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S964820AbWIDMSK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 08:18:10 -0400
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, Jeff Garzik <jeff@garzik.org>
Subject: Re: 2.6.18-rc5 + pata-drivers on MSI K9N Ultra report, AMD64
References: <m3psee58lg.fsf@defiant.localdomain>
	<1157234944.6271.400.camel@localhost.localdomain>
	<m3lkp1anwf.fsf@defiant.localdomain>
	<1157368595.30801.23.camel@localhost.localdomain>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Mon, 04 Sep 2006 14:18:07 +0200
In-Reply-To: <1157368595.30801.23.camel@localhost.localdomain> (Alan Cox's message of "Mon, 04 Sep 2006 12:16:35 +0100")
Message-ID: <m3mz9fu8ow.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

>>         static struct pci_bits amd_enable_bits[] = {
>>                 { 0x40, 1, 0x02, 0x02 },
>>                 { 0x40, 1, 0x01, 0x01 }
>>         };
>
> The Nvidia ones have the register base at 0x50. Looking at the code I
> think its just a case of adding an 0x50 based enable_bits test to
> nv_pre_reset, and I'll fold that in now.

I see. Thanks again.
-- 
Krzysztof Halasa

-- 
VGER BF report: H 1.57724e-07
