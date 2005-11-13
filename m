Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750707AbVKMVEl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750707AbVKMVEl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Nov 2005 16:04:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750708AbVKMVEk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Nov 2005 16:04:40 -0500
Received: from gate.crashing.org ([63.228.1.57]:63712 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1750707AbVKMVEk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Nov 2005 16:04:40 -0500
Subject: Re: [PATCH] ppc64: Thermal control for SMU based machines
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Paul Mackerras <paulus@samba.org>,
       Linux/PPC Development <linuxppc-dev@ozlabs.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.62.0511131845230.17491@numbat.sonytel.be>
References: <200511080502.jA852dWI011502@hera.kernel.org>
	 <Pine.LNX.4.62.0511131845230.17491@numbat.sonytel.be>
Content-Type: text/plain
Date: Mon, 14 Nov 2005 08:00:33 +1100
Message-Id: <1131915634.5504.69.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > --- a/drivers/macintosh/Kconfig
> > +++ b/drivers/macintosh/Kconfig
> > @@ -169,6 +169,25 @@ config THERM_PM72
> >  	  This driver provides thermostat and fan control for the desktop
> >  	  G5 machines. 
> >  
> > +config WINDFARM
> > +	tristate "New PowerMac thermal control infrastructure"
> 
> Shouldn't this depend on some PowerMac-related variables, to prevent it from
> showing up on m68k?

Well, the windfarm core is not really platform specific at all ...
Christoph even proposed to move it to some more "common" place, though
as I said, I want to work on it a bit more before that happens.

Ben.


