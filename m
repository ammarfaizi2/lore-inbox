Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030181AbWHCTN6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030181AbWHCTN6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 15:13:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030197AbWHCTN6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 15:13:58 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:22981 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1030181AbWHCTN5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 15:13:57 -0400
Subject: Re: [v4l-dvb-maintainer] [2.6 patch] DVB_CORE must select I2C
From: Mauro Carvalho Chehab <mchehab@infradead.org>
To: Trent Piepho <xyzzy@speakeasy.org>
Cc: Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
       v4l-dvb-maintainer@linuxtv.org, linux-kernel@vger.kernel.org,
       b.buschinski@web.de
In-Reply-To: <Pine.LNX.4.58.0608030918240.4264@shell3.speakeasy.net>
References: <20060727015639.9c89db57.akpm@osdl.org>
	 <20060803155925.GA25692@stusta.de>
	 <Pine.LNX.4.58.0608030918240.4264@shell3.speakeasy.net>
Content-Type: text/plain; charset=ISO-8859-1
Date: Thu, 03 Aug 2006 16:13:27 -0300
Message-Id: <1154632407.31483.28.camel@praia>
Mime-Version: 1.0
X-Mailer: Evolution 2.7.2.1-4mdv2007.0 
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hmm...
Em Qui, 2006-08-03 às 09:30 -0700, Trent Piepho escreveu:
> > This means people who observed a compile error will now have the DVB
> > support silently removed from their kernel.
I think Adrian's idea of selecting I2C, instead of depend on would be a
better approach for DVB_PLL.
> 
> This has been fixed differently already.  dvb-core.ko doesn't actually use
> I2C, only dvb-pll.ko does.  Now the dvb-pll.ko module is no longer turned
> on by DVB_CORE, but under a new option, DVB_PLL.  That option depends on
> I2C.
> 
Cheers, 
Mauro.

