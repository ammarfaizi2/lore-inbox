Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262626AbVCPPUE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262626AbVCPPUE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 10:20:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262616AbVCPPTv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 10:19:51 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:16336 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262625AbVCPPQW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 10:16:22 -0500
Subject: Re: Unresolved symbols in
	/lib/modules/2.4.28-pre2/xfree-drm/via_drv.o
From: Arjan van de Ven <arjan@infradead.org>
To: Martin =?iso-8859-2?Q?MOKREJ=A9?= 
	<mmokrejs@ribosome.natur.cuni.cz>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <42384AB9.1080905@ribosome.natur.cuni.cz>
References: <42384AB9.1080905@ribosome.natur.cuni.cz>
Content-Type: text/plain; charset=UTF-8
Date: Wed, 16 Mar 2005 16:16:10 +0100
Message-Id: <1110986170.6292.20.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 8bit
X-Spam-Score: 4.1 (++++)
X-Spam-Report: SpamAssassin version 2.63 on pentafluge.infradead.org summary:
	Content analysis details:   (4.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.3 RCVD_NUMERIC_HELO      Received: contains a numeric HELO
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

On Wed, 2005-03-16 at 16:03 +0100, Martin MOKREJŠ wrote:
> Hi,
>   does anyone still use 2.4 series kernel? ;)
> # make dep; make bzImage; make modules
> [cut]
> # make modules_install
> [cut]
> cd /lib/modules/2.4.30-pre3-bk2; \
> mkdir -p pcmcia; \
> find kernel -path '*/pcmcia/*' -name '*.o' | xargs -i -r ln -sf ../{} pcmcia
> if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.4.30-pre3-bk2; fi
> depmod: *** Unresolved symbols in /lib/modules/2.4.28-pre2/xfree-drm/via_drv.o

this is not the module shipped by the kernel.org kernel...


