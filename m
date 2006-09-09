Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751285AbWIIBWy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751285AbWIIBWy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 21:22:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751290AbWIIBWy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 21:22:54 -0400
Received: from flpi102.sbcis.sbc.com ([207.115.20.71]:9935 "EHLO
	flpi102.sbcis.sbc.com") by vger.kernel.org with ESMTP
	id S1751285AbWIIBWx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 21:22:53 -0400
X-ORBL: [68.95.116.149]
Message-ID: <45021744.1010705@ksu.edu>
Date: Fri, 08 Sep 2006 20:22:12 -0500
From: "Scott J. Harmon" <harmon@ksu.edu>
User-Agent: Thunderbird 1.5.0.5 (X11/20060727)
MIME-Version: 1.0
To: Grant Coady <gcoady.lk@gmail.com>
CC: Greg KH <gregkh@suse.de>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, torvalds@osdl.org, stable@kernel.org
Subject: Re: Linux 2.6.17.12
References: <20060908220741.GA26950@kroah.com> <6p14g2lcrt4mn7somaifh0sl5fqemdc5q5@4ax.com>
In-Reply-To: <6p14g2lcrt4mn7somaifh0sl5fqemdc5q5@4ax.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Grant Coady wrote:
> On Fri, 8 Sep 2006 15:07:41 -0700, Greg KH <gregkh@suse.de> wrote:
> 
>> We (the -stable team) are announcing the release of the 2.6.17.12 kernel.
> 
> I get this compile error:
> 
>   CC      drivers/ide/pci/via82cxxx.o
> drivers/ide/pci/via82cxxx.c:85: error: `PCI_DEVICE_ID_VIA_8237A' undeclared here (not in a function)
> drivers/ide/pci/via82cxxx.c:85: error: initializer element is not constant
> drivers/ide/pci/via82cxxx.c:85: error: (near initialization for `via_isa_bridges[3].id')
> drivers/ide/pci/via82cxxx.c:85: error: initializer element is not constant
> drivers/ide/pci/via82cxxx.c:85: error: (near initialization for `via_isa_bridges[3]')
> drivers/ide/pci/via82cxxx.c:86: error: initializer element is not constant
> drivers/ide/pci/via82cxxx.c:86: error: (near initialization for `via_isa_bridges[4]')
> drivers/ide/pci/via82cxxx.c:87: error: initializer element is not constant
> drivers/ide/pci/via82cxxx.c:87: error: (near initialization for `via_isa_bridges[5]')
> drivers/ide/pci/via82cxxx.c:88: error: initializer element is not constant
> drivers/ide/pci/via82cxxx.c:88: error: (near initialization for `via_isa_bridges[6]')
> drivers/ide/pci/via82cxxx.c:89: error: initializer element is not constant
> drivers/ide/pci/via82cxxx.c:89: error: (near initialization for `via_isa_bridges[7]')
> drivers/ide/pci/via82cxxx.c:90: error: initializer element is not constant
> drivers/ide/pci/via82cxxx.c:90: error: (near initialization for `via_isa_bridges[8]')
> drivers/ide/pci/via82cxxx.c:91: error: initializer element is not constant
> drivers/ide/pci/via82cxxx.c:91: error: (near initialization for `via_isa_bridges[9]')
> drivers/ide/pci/via82cxxx.c:92: error: initializer element is not constant
> drivers/ide/pci/via82cxxx.c:92: error: (near initialization for `via_isa_bridges[10]')
> drivers/ide/pci/via82cxxx.c:93: error: initializer element is not constant
> drivers/ide/pci/via82cxxx.c:93: error: (near initialization for `via_isa_bridges[11]')
> drivers/ide/pci/via82cxxx.c:94: error: initializer element is not constant
> drivers/ide/pci/via82cxxx.c:94: error: (near initialization for `via_isa_bridges[12]')
> drivers/ide/pci/via82cxxx.c:95: error: initializer element is not constant
> drivers/ide/pci/via82cxxx.c:95: error: (near initialization for `via_isa_bridges[13]')
> drivers/ide/pci/via82cxxx.c:96: error: initializer element is not constant
> drivers/ide/pci/via82cxxx.c:96: error: (near initialization for `via_isa_bridges[14]')
> drivers/ide/pci/via82cxxx.c:97: error: initializer element is not constant
> drivers/ide/pci/via82cxxx.c:97: error: (near initialization for `via_isa_bridges[15]')
> drivers/ide/pci/via82cxxx.c:98: error: initializer element is not constant
> drivers/ide/pci/via82cxxx.c:98: error: (near initialization for `via_isa_bridges[16]')
> drivers/ide/pci/via82cxxx.c:99: error: initializer element is not constant
> drivers/ide/pci/via82cxxx.c:99: error: (near initialization for `via_isa_bridges[17]')
> drivers/ide/pci/via82cxxx.c:100: error: initializer element is not constant
> drivers/ide/pci/via82cxxx.c:100: error: (near initialization for `via_isa_bridges[18]')
> drivers/ide/pci/via82cxxx.c:101: error: initializer element is not constant
> drivers/ide/pci/via82cxxx.c:101: error: (near initialization for `via_isa_bridges[19]')
> drivers/ide/pci/via82cxxx.c:102: error: initializer element is not constant
> drivers/ide/pci/via82cxxx.c:102: error: (near initialization for `via_isa_bridges[20]')
> drivers/ide/pci/via82cxxx.c:103: error: initializer element is not constant
> drivers/ide/pci/via82cxxx.c:103: error: (near initialization for `via_isa_bridges[21]')
> make[3]: *** [drivers/ide/pci/via82cxxx.o] Error 1
> make[2]: *** [drivers/ide/pci] Error 2
> make[1]: *** [drivers/ide] Error 2
> make: *** [drivers] Error 2
> 
> Tried twice, 5 of 6 targets okay, 1 of 6 not so good.
> 
> Grant.

Same here.  Unfortunately I am away from that machine and don't have the
.config here.  I can get it later if needed.

Thanks,

Scott.
-- 
"Computer Science is no more about computers than astronomy is about
telescopes." - Edsger Dijkstra
