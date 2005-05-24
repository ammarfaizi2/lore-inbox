Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262031AbVEXMhr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262031AbVEXMhr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 08:37:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262037AbVEXMhr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 08:37:47 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:39315 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262031AbVEXMhk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 08:37:40 -0400
Subject: Re: __udivdi3 and linux kernel u64 division question [x86]
From: Arjan van de Ven <arjan@infradead.org>
To: Mateusz Berezecki <mateuszb@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <42931E38.6030403@gmail.com>
References: <42931E38.6030403@gmail.com>
Content-Type: text/plain
Date: Tue, 24 May 2005 14:37:37 +0200
Message-Id: <1116938257.6280.21.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 3.7 (+++)
X-Spam-Report: SpamAssassin version 2.63 on pentafluge.infradead.org summary:
	Content analysis details:   (3.7 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	1.1 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
	2.5 RCVD_IN_DYNABLOCK      RBL: Sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	0.1 RCVD_IN_SORBS          RBL: SORBS: sender is listed in SORBS
	[80.57.133.107 listed in dnsbl.sorbs.net]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-05-24 at 14:29 +0200, Mateusz Berezecki wrote:
> Hi list members,
> 
> After a failure of compilation of the similar code snippet
> 
> 
> u64 mconst = somebig64bitvalue;
> u64 tmp = some32bitvalue;
> u64 r = mconst / tmp;

you shouldn't do this in linux

> I've also found a do_div() and it was sufficent for my purposes but Im
> still curious about
> __udivdi3. Can someone explain this issue to me?

do_div is a very small subset of divides.

Also.. you forgot to put the URL of your module into your email..



