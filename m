Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263259AbTIGNPJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Sep 2003 09:15:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263262AbTIGNPJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Sep 2003 09:15:09 -0400
Received: from amalthea.dnx.de ([193.108.181.146]:40850 "EHLO amalthea.dnx.de")
	by vger.kernel.org with ESMTP id S263259AbTIGNPF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Sep 2003 09:15:05 -0400
Date: Sun, 7 Sep 2003 15:14:43 +0200
From: Robert Schwebel <robert@schwebel.de>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Robert Schwebel <robert@schwebel.de>, linux-kernel@vger.kernel.org,
       Rusty Russell <rusty@rustcorp.com.au>,
       Russell King <rmk@arm.linux.org.uk>
Subject: Re: RFC: [2.6 patch] better i386 CPU selection
Message-ID: <20030907131443.GD5460@pengutronix.de>
References: <20030907112813.GQ14436@fs.tum.de> <20030907124251.GC5460@pengutronix.de> <20030907130034.GT14436@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030907130034.GT14436@fs.tum.de>
User-Agent: Mutt/1.4i
X-Spam-Score: -5.0 (----)
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *19vzN9-0000eI-00*MopXrBUxyG6*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 07, 2003 at 03:00:34PM +0200, Adrian Bunk wrote:
> I didn't look at the ARM Makefile. Thanks for the note, I'll have a
> look at it before I'll do the revision of this patch.

You should definitely discuss this with rmk. How do the PPC folks handle
CPU selection? 

> > Ack. Same with for example Geode. And the subarchs might have different
> 
> It seems the Geode support isn't fully merged in 2.6?

That's also my impression, although I didn't have much time to look at
the state. As far as I remember Christer Weinigel has recently done some
work in this direction. 

> It should be no problem to add a "Processor support" menu for the Elan
> that allows you to specify which Elan CPUs you plan to support.

Great. 

Robert 
-- 
 Dipl.-Ing. Robert Schwebel | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry
   Handelsregister:  Amtsgericht Hildesheim, HRA 2686
     Hornemannstraﬂe 12,  31137 Hildesheim, Germany
    Phone: +49-5121-28619-0 |  Fax: +49-5121-28619-4
