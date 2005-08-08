Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932090AbVHHPs2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932090AbVHHPs2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 11:48:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932091AbVHHPs2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 11:48:28 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:8390 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932090AbVHHPs1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 11:48:27 -0400
Subject: Re: [PATCH] drivers/video/sis/ macros for old kernels removal
From: Arjan van de Ven <arjan@infradead.org>
To: Jiri Slaby <jirislaby@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <42F778E2.2000602@gmail.com>
References: <42F775F6.8090600@gmail.com>  <42F778E2.2000602@gmail.com>
Content-Type: text/plain
Date: Mon, 08 Aug 2005 17:48:15 +0200
Message-Id: <1123516096.3245.46.camel@laptopd505.fenrus.org>
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

On Mon, 2005-08-08 at 17:23 +0200, Jiri Slaby wrote:
> Jiri Slaby napsal(a):
> 
> > This patch removes some #ifs, which controls kernel version (2.4 or 
> > like), so the code could be removed with the macros.
> > linux/version.h inclusions also removed.
> 
> Sorry, this was bad idea. X includes some of these file, doesn't it?

X can't depend on the version of the kernel anyway; the "version" in
version.h has no relation with the running kernel anyway (or with the
version of the kernel that will be used to run the X binaries on)

