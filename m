Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266030AbUBEUSB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 15:18:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266381AbUBEUSB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 15:18:01 -0500
Received: from fw.osdl.org ([65.172.181.6]:11737 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266030AbUBEURz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 15:17:55 -0500
Date: Thu, 5 Feb 2004 12:11:36 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: "Maciej Soltysiak" <solt@dns.toxicfilms.tv>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.2-mm1 [are these mine?]
Message-Id: <20040205121136.1538887f.rddunlap@osdl.org>
In-Reply-To: <000501c3ec22$46444bb0$0e25fe96@pysiak>
References: <20040205014405.5a2cf529.akpm@osdl.org>
	<200402051357.04005.s0348365@sms.ed.ac.uk>
	<4022505B.1020900@vision.ee>
	<000501c3ec22$46444bb0$0e25fe96@pysiak>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Feb 2004 20:57:17 +0100 "Maciej Soltysiak" <solt@dns.toxicfilms.tv> wrote:

| Hi,
| 
| 2.6.2-mm1 contains:
|  sound/oss/dmasound/tas3001c.c                                       1 +
| 1 -       0 !
|  sound/oss/dmasound/tas3001c_tables.c                              166 +
| 166 -       0 !
|  sound/oss/dmasound/tas3004_tables.c                               120 +
| 120 -       0 !
|  sound/oss/dmasound/trans_16.c                                      22 +
| 22 -       0 !
|  sound/oss/sb_card.h                                                50 +
| 50 -       0 !
| 
| I would like to ask if these are from the batch I proposed a while ago
| during 2.6.0 available at:
| http://soltysiak.com/patches/2.6/2.6.0/c99/patch-2.6.0-c99.diff
| split:
| http://soltysiak.com/patches/2.6/2.6.0/c99/split/
| 
| It would add to my other C99 contributed patches list :-)

Yes, they are yours.  I rediffed them and pushed them to Andrew
and the comment for them says:


[PATCH] janitor: sound/oss: use C99 inits.

From: "Randy.Dunlap" <rddunlap@osdl.org>,
      "Maciej Soltysiak" <solt@dns.toxicfilms.tv>

C99 initializers for linux/sound.



--
~Randy
kernel-janitors project:  http://janitor.kernelnewbies.org/
