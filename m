Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261589AbVEaVpl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261589AbVEaVpl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 17:45:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261539AbVEaVnp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 17:43:45 -0400
Received: from mail.emacinc.com ([208.248.202.76]:12165 "EHLO mail.emacinc.com")
	by vger.kernel.org with ESMTP id S261546AbVEaVm2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 17:42:28 -0400
From: NZG <ngustavson@emacinc.com>
Organization: EMAC.Inc
To: linux-kernel@vger.kernel.org
Date: Tue, 31 May 2005 16:41:00 -0500
User-Agent: KMail/1.7.1
References: <1117555756.4715.17.camel@diimka.dev.rtsoft.ru> <200506010044.34559.adobriyan@gmail.com>
In-Reply-To: <200506010044.34559.adobriyan@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200505311641.00509.ngustavson@emacinc.com>
X-SA-Exim-Connect-IP: 208.248.202.77
X-SA-Exim-Mail-From: ngustavson@emacinc.com
Subject: Re: [RFC] SPI core
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

SPI is serial-peripheral interface. A very common 3 wire bus in embedded 
systems, especially m68k arch's. That fact that it's not there already is 
actually a little weird IMHO.

NZG.

On Tuesday 31 May 2005 15:44, Alexey Dobriyan wrote:
> On Tuesday 31 May 2005 20:09, dmitry pervushin wrote:
> > In order to support the specific board, we have ported the generic SPI
> > core to the 2.6 kernel. This core provides basic API to create/manage SPI
> > devices like the I2C core does. We need to continue providing support of
> > SPI devices and would like to maintain the SPI subtree.
> >
> > +#ifdef CONFIG_DEVFS_FS
> > +#include <linux/devfs_fs_kernel.h>
> > +#endif
>
> devfs will be removed from mainline in a month.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
