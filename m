Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264263AbUEMPrV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264263AbUEMPrV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 11:47:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264268AbUEMPrV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 11:47:21 -0400
Received: from mtaw4.prodigy.net ([64.164.98.52]:40399 "EHLO mtaw4.prodigy.net")
	by vger.kernel.org with ESMTP id S264263AbUEMPrT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 11:47:19 -0400
Message-ID: <40A397C7.5020209@pacbell.net>
Date: Thu, 13 May 2004 08:44:07 -0700
From: David Brownell <david-b@pacbell.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en, fr
MIME-Version: 1.0
To: lkml@lpbproductions.com
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-mm2
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>   CC [M]  drivers/usb/host/ohci-hcd.o
> In file included from drivers/usb/host/ohci-hcd.c:129:
> drivers/usb/host/ohci-hub.c: In function `ohci_rh_resume':
> drivers/usb/host/ohci-hub.c:313: error: `hcd' undeclared (first use in this 
> function)
> drivers/usb/host/ohci-hub.c:313: error: (Each undeclared identifier is 
> reported only once
> drivers/usb/host/ohci-hub.c:313: error: for each function it appears in.)
> drivers/usb/host/ohci-hub.c:313: warning: unused variable `ohci'
> make[3]: *** [drivers/usb/host/ohci-hcd.o] Error 1
> make[2]: *** [drivers/usb/host] Error 2
> make[1]: *** [drivers/usb] Error 2

Enable CONFIG_PM or apply the patch from

   http://marc.theaimsgroup.com/?l=linux-usb-devel&m=108440030418181&w=2

Sorry about that.

- Dave


