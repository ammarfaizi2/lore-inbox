Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932225AbWIJPRN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932225AbWIJPRN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Sep 2006 11:17:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932227AbWIJPRN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Sep 2006 11:17:13 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:52161 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932225AbWIJPRK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Sep 2006 11:17:10 -0400
Subject: Re: [v4l-dvb-maintainer] DVB build fails without I2C
From: Mauro Carvalho Chehab <mchehab@infradead.org>
To: Manu Abraham <abraham.manu@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, v4l-dvb-maintainer@linuxtv.org,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jeff@garzik.org>
In-Reply-To: <1157894226.4359.10.camel@praia>
References: <45029DB0.5020300@garzik.org>  <4502DA2F.5050905@gmail.com>
	 <1157894226.4359.10.camel@praia>
Content-Type: text/plain; charset=ISO-8859-1
Date: Sun, 10 Sep 2006 12:16:43 -0300
Message-Id: <1157901403.4359.15.camel@praia>
Mime-Version: 1.0
X-Mailer: Evolution 2.7.92-1mdv2007.0 
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Dom, 2006-09-10 às 10:17 -0300, Mauro Carvalho Chehab escreveu:
> Em Sáb, 2006-09-09 às 19:13 +0400, Manu Abraham escreveu:
> > Jeff Garzik wrote:
> > > Recommended solution:  Add I2C as a dependency (or select) in DVB Kconfig.
> > DVB-CORE does not depend on I2C
> > Maybe that patch has not made it yet to mainline.
> No, it didn't arrived mainstream.
> (I'm not sure but I think it was adq).
Yes, it was adq. He sent us a proper patch. I'm testing it the proper
patch at the kernel, with allmodconfig, then without i2c. If it works
fine, I'll send today to Linus to be included at mainstream.

Cheers, 
Mauro.

