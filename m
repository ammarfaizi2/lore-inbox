Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750986AbWITKOv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750986AbWITKOv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 06:14:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750990AbWITKOu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 06:14:50 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:29085 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1750971AbWITKOt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 06:14:49 -0400
Subject: Re: [PATCH] Adds kernel parameter to ignore pci devices
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jarek Poplawski <jarkao2@o2.pl>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org, luizluca@gmail.com
In-Reply-To: <20060920064114.GA1697@ff.dom.local>
References: <20060920064114.GA1697@ff.dom.local>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 20 Sep 2006 11:38:53 +0100
Message-Id: <1158748734.7705.4.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Mer, 2006-09-20 am 08:41 +0200, ysgrifennodd Jarek Poplawski:
> On 20-09-2006 02:01, Alan Cox wrote:
> > Not sure its the way I'd approach it - in your specific case it should
> > be easier to just not compile in EHCI (USB 2.0) support.
>  
> I'd dare to vote for this idea: it's good for testing
> and very practical eg. for comparing performance of similar
> devices like network or sound cards. Besides: ehci could
> work for other devices.

In which case you'd need to specify the device to ignore by its PCI bus
address so could ignore one device but not another of the same type. Eg
pci=ignore=0:4.5


