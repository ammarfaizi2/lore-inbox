Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932240AbVLDOvE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932240AbVLDOvE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Dec 2005 09:51:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932241AbVLDOvE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Dec 2005 09:51:04 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:19431 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932240AbVLDOvC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Dec 2005 09:51:02 -0500
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
Date: Sun, 04 Dec 2005 15:50:55 +0100
Message-Id: <1133707855.5188.41.camel@laptopd505.fenrus.org>
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

On Sun, 2005-12-04 at 15:25 +0100, Matthias Andree wrote:
> On Sun, 04 Dec 2005, Arjan van de Ven wrote:
> 
> > On Sun, 2005-12-04 at 14:28 +0100, Matthias Andree wrote:
> > 
> > > I meant the ipmi, smbus and copa modules by Fujitsu-Siemens.
> > > 
> > > They are provided in source form, but I just found out (reading the
> > > headers and not just the lines that broke the compile) they are not open
> > > source. Perhaps one should prod them to slap a modified-BSD or perhaps
> > > GPL label onto their modules.
> > 
> > is there an URL to these?
> 
> http://download.fujitsu-siemens.com/prim_supportcd/Programs/General/ServView/Linux/agents/srvmagt-mods_src.suse.rpm
> 
> > > It seems you'd then maintain them after their submission? :-)
> > 
> > usually such modules are extremely low maintenance once merged.... There
> > are many many drivers without a maintainer, and they still get fixed.
> 
> As I say, these aren't licensed for inclusion into the kernel, they bear
> a (C) Copyright notice and "All rights reserved."

and
MODULE_LICENSE("GPL");

so it *IS* gpl licensed!

the code is a bit horrible though and no surprise it breaks ;)

you can always make drivers broken enough to break at the slightest
change ;)

(it also seems to contain an entire ipmi layer, linux already has one so
I wonder why they're not just using that as basis)



