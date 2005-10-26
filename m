Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751180AbVJZWW3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751180AbVJZWW3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Oct 2005 18:22:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751266AbVJZWW3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Oct 2005 18:22:29 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:14253 "EHLO smtp1-g19.free.fr")
	by vger.kernel.org with ESMTP id S1751180AbVJZWW3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Oct 2005 18:22:29 -0400
Message-ID: <436001A3.1000906@free.fr>
Date: Thu, 27 Oct 2005 00:22:27 +0200
From: Laurent Riffard <laurent.riffard@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.7.11) Gecko/20050729
X-Accept-Language: fr-fr, fr, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: linux-kernel@vger.kernel.org, Al Viro <viro@ftp.linux.org.uk>,
       Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [RFC patch 3/3] remove pci_driver.owner and .name fields
References: <20051026204802.123045000@antares.localdomain> <20051026204909.995658000@antares.localdomain> <20051026211129.GA7918@kroah.com>
In-Reply-To: <20051026211129.GA7918@kroah.com>
X-Enigmail-Version: 0.92.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Le 26.10.2005 23:11, Greg KH a écrit :
> On Wed, Oct 26, 2005 at 10:48:05PM +0200, Laurent riffard wrote:
> 
>>This is the final cleanup : deletion of pci_driver.name and .owner
>>happens now. 
> 
> 
> what?  Did you actually try to build a kernel with this patch applied?

No, a bunch of patch #2-like have to be applied first.

This third patch is to be applied after *all* the drivers are
converted to use the pci_driver.driver.{name|owner} fields.

> Sorry, but I think we have to wait a long time before this can be
> appliedr...

Yes, I know. Is it worth to do it ?

> thanks,
> 
> greg k-h

thanks
--
laurent

