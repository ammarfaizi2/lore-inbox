Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750758AbVHHIRo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750758AbVHHIRo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 04:17:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750759AbVHHIRo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 04:17:44 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:50920 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750758AbVHHIRo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 04:17:44 -0400
Subject: Re: Highmemory Problem with RHEL3 .... 2.4.21-5.ELsmp
From: Arjan van de Ven <arjan@infradead.org>
To: Fawad Lateef <fawadlateef@gmail.com>
Cc: linux-kernel@vger.kernel.org, nhorman@redhat.com
In-Reply-To: <1e62d137050807205047daf9e0@mail.gmail.com>
References: <1e62d137050807205047daf9e0@mail.gmail.com>
Content-Type: text/plain
Date: Mon, 08 Aug 2005 10:17:35 +0200
Message-Id: <1123489056.3245.28.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 2.9 (++)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (2.9 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	2.8 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-08-08 at 08:50 +0500, Fawad Lateef wrote:
> Hello,
> 
> I m facing a problem in RHEL3 (2.4.21-5.ELsmp) kernel while using
> kmap_atomic on the pages reserved at the boot time !!!!
> 
> At the boot time I reserved pages above 2GB for later use by my module
> ..... And when I was using those reserved pages through kmap_atomic
> system hangs; although kmap_atomic successfully returns me the virtual
> address but when I use that virtual address like in memcpy the system
> hangs .....

1) you probably should use RH support for this
2) you forgot to attach your sourcecode / URL to that, including the
   full source of your module.


