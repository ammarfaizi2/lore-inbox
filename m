Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751348AbVJQGi7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751348AbVJQGi7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 02:38:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751362AbVJQGi7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 02:38:59 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:57806 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751348AbVJQGi6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 02:38:58 -0400
Subject: Re: PATCH: EDAC, core EDAC support code
From: Arjan van de Ven <arjan@infradead.org>
To: Doug Thompson <norsk5@yahoo.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20051017014845.16415.qmail@web50112.mail.yahoo.com>
References: <20051017014845.16415.qmail@web50112.mail.yahoo.com>
Content-Type: text/plain
Date: Mon, 17 Oct 2005 08:38:39 +0200
Message-Id: <1129531119.2907.1.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
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

On Sun, 2005-10-16 at 18:48 -0700, Doug Thompson wrote:
> > why proc? Again this sounds like a platform sysfs
> > thing...
> 
> The plan is to move from /proc to sysfs operations,
> info and control. But the core works at this time and
> patches will be forth coming once the baseline is in.
> We want to make the currently work features "work".


that doesn't work that way.. with the /proc stuff you add an api/abi,
which you can't get rid of afterwards, so it's important to get that
right from the start..... 

