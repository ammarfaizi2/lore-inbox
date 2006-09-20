Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751914AbWITRD5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751914AbWITRD5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 13:03:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751958AbWITRD4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 13:03:56 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:32211 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751914AbWITRDz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 13:03:55 -0400
Subject: Re: [PATCH] Adds kernel parameter to ignore pci devices
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc: Jarek Poplawski <jarkao2@o2.pl>, linux-kernel@vger.kernel.org,
       torvalds@osdl.org
In-Reply-To: <8b96e3d20609200951h6b70c261odff1db1913d13d10@mail.gmail.com>
References: <20060920064114.GA1697@ff.dom.local>
	 <1158748734.7705.4.camel@localhost.localdomain>
	 <20060920112559.GC1697@ff.dom.local>
	 <8b96e3d20609200951h6b70c261odff1db1913d13d10@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 20 Sep 2006 18:27:46 +0100
Message-Id: <1158773267.7705.13.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Mer, 2006-09-20 am 13:51 -0300, ysgrifennodd Luiz Angelo Daros de
Luca:
> Allan, disabling EHCI in kernel won't solve it cause the kernel
> freezes when linux is setting up pci. This is before any device
> specific driver and it is done even without any driver for that
> device.
> 
> I was going to implement a way to ignore using bus+board+function but
> not at this time. BTW, are the parameters name, format and debug
> messages adequated to kernel's principels?

I think so yes. The actual names used are a minor detail to worry about
once the code is working, neat and being submitted.

Alan

