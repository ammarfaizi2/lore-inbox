Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932249AbVLDPUw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932249AbVLDPUw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Dec 2005 10:20:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932250AbVLDPUw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Dec 2005 10:20:52 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:6603 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932249AbVLDPUv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Dec 2005 10:20:51 -0500
Subject: Re: RFC: Starting a stable kernel series off the 2.6 kernel
From: Arjan van de Ven <arjan@infradead.org>
To: Matthias Andree <matthias.andree@gmx.de>
Cc: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <20051204142551.GB4769@merlin.emma.line.org>
References: <1133620598.22170.14.camel@laptopd505.fenrus.org>
	 <20051203152339.GK31395@stusta.de>
	 <20051203162755.GA31405@merlin.emma.line.org>
	 <1133630556.22170.26.camel@laptopd505.fenrus.org>
	 <20051203230520.GJ25722@merlin.emma.line.org>
	 <43923DD9.8020301@wolfmountaingroup.com>
	 <20051204121209.GC15577@merlin.emma.line.org>
	 <1133699555.5188.29.camel@laptopd505.fenrus.org>
	 <20051204132813.GA4769@merlin.emma.line.org>
	 <1133703338.5188.38.camel@laptopd505.fenrus.org>
	 <20051204142551.GB4769@merlin.emma.line.org>
Content-Type: text/plain
Date: Sun, 04 Dec 2005 16:20:48 +0100
Message-Id: <1133709649.5188.54.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 1.8 (+)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (1.8 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[213.93.14.173 listed in dnsbl.sorbs.net]
	1.7 RCVD_IN_NJABL_DUL      RBL: NJABL: dialup sender did non-local SMTP
	[213.93.14.173 listed in combined.njabl.org]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  (C) Copyright notice and "All rights reserved."
> 
> > > These use inter_module_get() 
> > 
> > which is still there even in the latest 2.6.15-rc. It should be going
> > out but hasn't yet. And that is the case for at least a year (eg they
> > are __deprecated but still there).
> 
> No, they aren't - at least not anywhere declared below include/ and thus
> uncompilable with GCC4.

# pwd
/mnt/raid/linux/linux-2.6.15-rc4/include/linux
[root@jackhammer linux]# grep inter_mod *
module.h:extern void __deprecated inter_module_register(const char *,
module.h:extern void __deprecated inter_module_unregister(const char *);
module.h:extern const void * __deprecated inter_module_get_request(const
char *,
module.h:extern void __deprecated inter_module_put(const char *);


sounds you need to invoke the warranty on your grep binary ;)




