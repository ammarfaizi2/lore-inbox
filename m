Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263179AbTJUP5R (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Oct 2003 11:57:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263181AbTJUP5R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Oct 2003 11:57:17 -0400
Received: from [65.172.181.6] ([65.172.181.6]:47040 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263179AbTJUP5Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Oct 2003 11:57:16 -0400
Date: Tue, 21 Oct 2003 08:55:42 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Joilnen Leite <knl_joi@yahoo.com.br>
Cc: macro@ds2.pg.gda.pl, linux-kernel@vger.kernel.org
Subject: Re: request_region
Message-Id: <20031021085542.60a666f2.rddunlap@osdl.org>
In-Reply-To: <20031021094451.33861.qmail@web40310.mail.yahoo.com>
References: <20031021094451.33861.qmail@web40310.mail.yahoo.com>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Oct 2003 06:44:51 -0300 (ART) Joilnen Leite <knl_joi@yahoo.com.br> wrote:

| excuse me but
| 
| line 400 in  drivers/net/skfp/skfddi.c there are a
| request_region for dev->base_addr
| 
| and I can't se it released in 428 line for example :) 

Why would the region be released at the end of skfp_probe()?

--
~Randy
