Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261365AbVAIMby@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261365AbVAIMby (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jan 2005 07:31:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261369AbVAIMby
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jan 2005 07:31:54 -0500
Received: from canuck.infradead.org ([205.233.218.70]:63248 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S261365AbVAIMbo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jan 2005 07:31:44 -0500
Subject: Re: Conflicts in kernel 2.6 headers and {glibc,Xorg}
From: Arjan van de Ven <arjan@infradead.org>
To: DervishD <lkml@dervishd.net>
Cc: Michal Feix <michal@feix.cz>, linux-kernel@vger.kernel.org
In-Reply-To: <20050109122557.GA221@DervishD>
References: <41E0F76D.7080805@feix.cz> <20050109110805.GA8688@irc.pl>
	 <41E1170D.6090405@feix.cz> <20050109115554.GA9183@irc.pl>
	 <20050109122557.GA221@DervishD>
Content-Type: text/plain
Date: Sun, 09 Jan 2005 13:31:32 +0100
Message-Id: <1105273893.4173.12.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 4.1 (++++)
X-Spam-Report: SpamAssassin version 2.63 on canuck.infradead.org summary:
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
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-01-09 at 13:25 +0100, DervishD wrote:
>     Hi All :)
> 
>  * Tomasz Torcz <zdzichu@irc.pl> dixit:
> >  Mainstream distributions use ,,sanitized'' version o kernel
> > headers - Fedora has own set, Debian has another, LFS too. For rest
> > and for us, casual users, there are headers made as byproduct of
> > PLD Linux, which are used since december 2003 (before kernel 2.6
> > was even released).
> 
>     But the set of sanitized kernel headers, if you build your own
> software and you're not using a distro, is only available for 2.6.x
> kernels, not for 2.4.x kernels. 

The headers RH ships work for both...
>
> What should be done for 2.4 kernels?
> I currently use a set of headers from the 2.4 kernel I used to build
> my libc, not the headers from the current kernel I'm running, but I
> would like to know anyway.

.... and you can use 2.6 headers to build a glibc that works excellent
for 2.4 kernels too. The kernel API/ABI *does not change on this level*
between kernel versions. Things may get added, but they do not change.


