Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030406AbWHUMQw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030406AbWHUMQw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 08:16:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030419AbWHUMQv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 08:16:51 -0400
Received: from mtagate2.de.ibm.com ([195.212.29.151]:45694 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP
	id S1030406AbWHUMQu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 08:16:50 -0400
Message-ID: <44E9A42F.3000900@de.ibm.com>
Date: Mon, 21 Aug 2006 14:16:47 +0200
From: Thomas Klein <osstklei@de.ibm.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Alexey Dobriyan <adobriyan@gmail.com>
CC: Jan-Bernd Themann <ossthema@de.ibm.com>, netdev@vger.kernel.org,
       Christoph Raisch <raisch@de.ibm.com>,
       Jan-Bernd Themann <themann@de.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-ppc <linuxppc-dev@ozlabs.org>, Marcus Eder <meder@de.ibm.com>,
       Thomas Klein <tklein@de.ibm.com>
Subject: Re: [2.6.19 PATCH 7/7] ehea: Makefile & Kconfig
References: <200608181337.44153.ossthema@de.ibm.com> <20060818141847.GE5201@martell.zuzino.mipt.ru>
In-Reply-To: <20060818141847.GE5201@martell.zuzino.mipt.ru>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexey Dobriyan wrote:
 > On Fri, Aug 18, 2006 at 01:37:44PM +0200, Jan-Bernd Themann wrote:
 >> --- linux-2.6.18-rc4/drivers/net/Kconfig
 >> +++ patched_kernel/drivers/net/Kconfig
 >> @@ -2277,6 +2277,12 @@ config CHELSIO_T1
 >>            To compile this driver as a module, choose M here: the module
 >>            will be called cxgb.
 >>
 >> +config EHEA
 >> +        tristate "eHEA Ethernet support"
 >> +        depends on IBMEBUS
 >> +        ---help---
 >> +          This driver supports the IBM pSeries ethernet adapter
 >                                                                 .
 >
 > People usually add the following boilerplate:
 >
 >       To compile this driver as a module, choose M here: the module
 >       will be called $FOO.

Agreed.
