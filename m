Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965071AbWIENob@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965071AbWIENob (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 09:44:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965069AbWIENob
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 09:44:31 -0400
Received: from h155.mvista.com ([63.81.120.155]:35966 "EHLO imap.sh.mvista.com")
	by vger.kernel.org with ESMTP id S965064AbWIENo3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 09:44:29 -0400
Message-ID: <44FD7FBD.2060309@ru.mvista.com>
Date: Tue, 05 Sep 2006 17:46:37 +0400
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To: John Stoffel <john@stoffel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Jeff Garzik <jeff@garzik.org>,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: PATA drivers queued for 2.6.19
References: <44FC0779.9030405@garzik.org>	<1157371363.30801.31.camel@localhost.localdomain> <17661.31750.457301.687508@smtp.charter.net>
In-Reply-To: <17661.31750.457301.687508@smtp.charter.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Stoffel wrote:
>>>>>>"Alan" == Alan Cox <alan@lxorguk.ukuu.org.uk> writes:
> 
> 
> Alan> Ar Llu, 2006-09-04 am 07:01 -0400, ysgrifennodd Jeff Garzik:
> 
>>>The following must be in all caps, though:
>>>
>>>drivers/ide IS STILL THE PATA DRIVER SET THAT USERS AND DISTROS SHOULD 
>>>CHOOSE.
> 
> 
> Alan> Except optionally for the following for chips not handled by or broken
> Alan> totally in drivers/ide:
> 
> Alan> 	pata_mpiix - some early pentium era laptops
> Alan> 	pata_oldpiix - original "PIIX" chipset
> Alan> 	pata_radisys - embedded chipset
> 
> What about pata_hpt37x and it's failure to work with my HPT302 Rev one
> controller?  I admit it could be just an IRQ problem, but since
> 2.6.18-rc5-mm1 works with the old ide/pci/hpt366.c, but not with the

    Hm, I believe this driver hasn't been updated since 2.617-mm4 (I have one 
patch pending still).

> new version?  It's using the same interrupt each time too.

    What's up with it?
