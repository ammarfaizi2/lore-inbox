Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261243AbTIGS0d (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Sep 2003 14:26:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263411AbTIGS0d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Sep 2003 14:26:33 -0400
Received: from amalthea.dnx.de ([193.108.181.146]:53655 "EHLO amalthea.dnx.de")
	by vger.kernel.org with ESMTP id S261243AbTIGS0b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Sep 2003 14:26:31 -0400
Date: Sun, 7 Sep 2003 20:26:29 +0200
From: Robert Schwebel <robert@schwebel.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Robert Schwebel <robert@schwebel.de>, Adrian Bunk <bunk@fs.tum.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Rusty Russell <rusty@rustcorp.com.au>,
       Russell King <rmk@arm.linux.org.uk>
Subject: Re: RFC: [2.6 patch] better i386 CPU selection
Message-ID: <20030907182628.GC482@pengutronix.de>
References: <20030907112813.GQ14436@fs.tum.de> <20030907124251.GC5460@pengutronix.de> <20030907130034.GT14436@fs.tum.de> <1062955895.16972.13.camel@dhcp23.swansea.linux.org.uk> <20030907174834.GA482@pengutronix.de> <1062957851.16964.42.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1062957851.16964.42.camel@dhcp23.swansea.linux.org.uk>
User-Agent: Mutt/1.4i
X-Spam-Score: -5.0 (----)
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *19w4Er-0003wK-00*L1YqsD8zqtI*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 07, 2003 at 07:04:12PM +0100, Alan Cox wrote:
> ELAN is "like a PC", Geode is a PC, to software. You can run a generic
> 386/486/586/586+MMX kernel on a Geode CPU. The Geode support just picks
> the right compile options and our setup code turns on some handy CPU
> features we can use

Hmm, I'm not so sure. I've not much experience with Geode yet, but from
my first RTAI tests it surely has several problems which might require
an #ifdef CONFIG_MGEODE or something similar. As long as this is
possible everything's ok with me ;)

Robert
-- 
 Dipl.-Ing. Robert Schwebel | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry
   Handelsregister:  Amtsgericht Hildesheim, HRA 2686
     Hornemannstraﬂe 12,  31137 Hildesheim, Germany
    Phone: +49-5121-28619-0 |  Fax: +49-5121-28619-4
