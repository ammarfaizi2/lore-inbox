Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261265AbVDIDeg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261265AbVDIDeg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 23:34:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261266AbVDIDeg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 23:34:36 -0400
Received: from ccerelrim03.cce.hp.com ([161.114.21.24]:6822 "EHLO
	ccerelrim03.cce.hp.com") by vger.kernel.org with ESMTP
	id S261265AbVDIDe1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 23:34:27 -0400
Message-ID: <1539.24.9.197.67.1113017666.squirrel@mail.cce.hp.com>
In-Reply-To: <4257247B.8030604@pin.if.uz.zgora.pl>
References: <424D44F0.6090707@web.de> <424D5E2E.8040207@pin.if.uz.zgora.pl>	
    <424D71DE.5060703@web.de> <424D91B5.50404@pin.if.uz.zgora.pl>	
    <424D9A9C.2070705@web.de>  <424D9FCE.6020200@pin.if.uz.zgora.pl>
    <1112993039.12025.65.camel@eeyore>
    <4257247B.8030604@pin.if.uz.zgora.pl>
Date: Fri, 8 Apr 2005 21:34:26 -0600 (MDT)
Subject: Re: PCI-Express not working/unuseable on Intel 925XE Chipset since 
     2.6.12-rc1[mm1-4]
From: "Bjorn Helgaas" <bjorn.helgaas@hp.com>
To: "Jacek Luczak" <difrost@pin.if.uz.zgora.pl>
Cc: "Bjorn Helgaas" <bjorn.helgaas@hp.com>, linux-kernel@vger.kernel.org,
       "Michael Thonke" <tk-shockwave@web.de>
User-Agent: SquirrelMail/1.4.4
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
X-PMX-Version: 5.0.0.131485, Antispam-Engine: 2.0.3.1, Antispam-Data: 2005.4.8.20
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Version from syskonnect site require only changing usage of
> pci_dev->slot_name to pci_name(pci_dev) in skge.c and skethtool.c. After
> that everything should work fine. So I think there is no need to post my
> path here but if you really whant I may do this. Whole path agains
> 2.6.12-rc2 take about 1.2 MB (diffstat attached below).

I agree, no need to post a whole 1.2MB patch (goodness, what's
in this driver, anyway, that it would need a 1.2MB *patch*? :-))

But you seem to be saying that the driver from syskonnect (and possibly
the one in 2.6.12-rc1-bk3 as well) does not work as-is, and that you have
a small patch that makes it work.

If so, I think it's worth posting the small patch, so other users
of the device can at least get it working until syskonnect gets
things squared away.

My apologies if I'm misunderstanding the situation.

