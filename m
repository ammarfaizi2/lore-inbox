Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261900AbVDOSOw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261900AbVDOSOw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Apr 2005 14:14:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261893AbVDOSN7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Apr 2005 14:13:59 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:44193 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261900AbVDOSLi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Apr 2005 14:11:38 -0400
Subject: Re: intercepting syscalls
From: Arjan van de Ven <arjan@infradead.org>
To: Igor Shmukler <igor.shmukler@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <6533c1c905041511041b846967@mail.gmail.com>
References: <6533c1c905041511041b846967@mail.gmail.com>
Content-Type: text/plain
Date: Fri, 15 Apr 2005 20:11:34 +0200
Message-Id: <1113588694.6694.75.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
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

On Fri, 2005-04-15 at 14:04 -0400, Igor Shmukler wrote:
> Hello,
> We are working on a LKM for the 2.6 kernel.
> We HAVE to intercept system calls. I understand this could be
> something developers are no encouraged to do these days, but we need
> this.

your module is GPL licensed right ? (You're depending on deep internals
after all)

Why do you *have* to intercept system calls... can't you instead use the
audit infrastructure to get that information ?

What is the URL of your current code so that we can provide reasonable
recommendations ?


