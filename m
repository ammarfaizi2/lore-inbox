Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315867AbSEMHv5>; Mon, 13 May 2002 03:51:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315866AbSEMHv4>; Mon, 13 May 2002 03:51:56 -0400
Received: from green.mif.pg.gda.pl ([153.19.42.8]:47620 "EHLO
	green.mif.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S310806AbSEMHvz>; Mon, 13 May 2002 03:51:55 -0400
From: Andrzej Krzysztofowicz <ankry@green.mif.pg.gda.pl>
Message-Id: <200205130751.JAA19259@green.mif.pg.gda.pl>
Subject: Re: [PATCH] CONFIG_ISA
To: thunder@ngforever.de
Date: Mon, 13 May 2002 09:51:09 +0200 (CEST)
Cc: axel@hh59.org, ak@muc.de, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org
Reply-To: om@green.mif.pg.gda.pl, "Thunder from the hill"@green.mif.pg.gda.pl,
        at@green.mif.pg.gda.pl, May@green.mif.pg.gda.pl,
        12@green.mif.pg.gda.pl, 2@green.mif.pg.gda.pl,
        01:00:36@green.mif.pg.gda.pl, pm@green.mif.pg.gda.pl
In-Reply-To: <Pine.LNX.4.44.0205121258430.4369-100000@hawkeye.luckynet.adm> from "Thunder from the hill" at May 12, 2 01:00:36 pm
X-Mailer: ELM [version 2.5 PL0pre8]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"F wrote:"
> On Sun, 12 May 2002, Axel H. Siebenwirth wrote:
> > Isn't there a config option called CONFIG_EISA?
> 
> Indeed.
> 
> > Which is about the same as ISA?
> 
> Nope, it's for EISA stuff (enhanced industry standard arch). It differs 
> somewhat from what we know as ISA. A computer can have ISA bus and no 
> EISA, and vv.
           ^^^^

I think that EISA support with no ISA support should not be assumed.
AFAIK, EISA support provides ISA support as EISA is a superset of ISA. 

so 
CONFIG_EISA = "y"   should imply   CONFIG_ISA = "y"
CONFIG_ISA = "n"    should imply   CONFIG_EISA = "n"

Andrzej
-- 
=======================================================================
  Andrzej M. Krzysztofowicz               ankry@mif.pg.gda.pl
  phone (48)(58) 347 14 61
Faculty of Applied Phys. & Math.,   Technical University of Gdansk
