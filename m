Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966917AbWKUImD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966917AbWKUImD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 03:42:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966927AbWKUImD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 03:42:03 -0500
Received: from wx-out-0506.google.com ([66.249.82.233]:36209 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S966917AbWKUImA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 03:42:00 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=fnxYLhlXOieu9Y7dwertNkLC06AgCVeaklvKo/WoLmHi/HAODb87bQxdA/SUNUkYo9d3ECF2a4TO0C24BYuDUhhpJxUE6vLspBJI1T/V0MJISPvmXI4+4yoOTZkaayDE9LVwdwxfwxDUv2LvU8lSWRJUEQYYD6ZUYioWzcoKY6A=
Message-ID: <3a5b1be00611210042p2237a0fbpece68912e3d23f4c@mail.gmail.com>
Date: Tue, 21 Nov 2006 10:42:00 +0200
From: "Komal Shah" <komal.shah802003@gmail.com>
To: Vladimir <vovan888@gmail.com>
Subject: Re: Siemens sx1: merge framebuffer support
Cc: "Tony Lindgren" <tony@atomide.com>, "Pavel Machek" <pavel@ucw.cz>,
       "kernel list" <linux-kernel@vger.kernel.org>
In-Reply-To: <ce55079f0611202306l3cd57e48t68fe28e7e076d39a@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061118181607.GA15275@elf.ucw.cz>
	 <20061120190404.GD4597@atomide.com>
	 <ce55079f0611202306l3cd57e48t68fe28e7e076d39a@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/21/06, Vladimir <vovan888@gmail.com> wrote:
> 2006/11/20, Tony Lindgren <tony@atomide.com>:
> > * Pavel Machek <pavel@ucw.cz> [061118 18:16]:
> > > From: Vladimir Ananiev <vovan888@gmail.com>
> > >
> > > Framebuffer support for Siemens SX1; this is second big patch. (Third
> > > one will be mixer/sound support). Support is simple / pretty minimal,
> > > but seems to work okay (and is somehow important for a cell phone :-).
> >
> > Pushed to linux-omap. I guess you're planning to send the missing
> > Kconfig + Makefile patch for this?
> >
> > Also, it would be better to use omap_mcbsp_xmit_word() or
> > omap_mcsbsp_spi_master_xmit_word_poll() instead of OMAP_MCBSP_WRITE as
> > it does not do any checking that it worked. The aic23 and tsc2101
> > audio in linux-omap tree in general has the same problem.
> >
> > Regards,
> >
> > Tony
> >
>
> Hmm. McBSP3 in SX1 is used in "GPIO mode". The only line used is CLKX,
> so I think OMAP_MCBSP_WRITE would be enough. Am I wrong ?

Please also send defconfig (may be siemens_sx1_defconfig OR
omap_sx1_310_defconfig) patch for this mobile once, your minimum
required patches are pushed to -omap git tree. Thanx.

-- 
---Komal Shah
http://komalshah.blogspot.com
