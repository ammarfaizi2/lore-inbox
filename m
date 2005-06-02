Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261171AbVFBH4a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261171AbVFBH4a (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Jun 2005 03:56:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261165AbVFBH4a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Jun 2005 03:56:30 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:2541 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261171AbVFBH4Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Jun 2005 03:56:25 -0400
Subject: Re: Accessing monotonic clock from modules
From: Arjan van de Ven <arjan@infradead.org>
To: Robert Love <rml@novell.com>
Cc: Mikael Starvik <mikael.starvik@axis.com>, linux-kernel@vger.kernel.org
In-Reply-To: <1117698764.6833.26.camel@jenny.boston.ximian.com>
References: <BFECAF9E178F144FAEF2BF4CE739C66801B7645C@exmail1.se.axis.com>
	 <1117697423.6458.18.camel@laptopd505.fenrus.org>
	 <1117698045.6833.16.camel@jenny.boston.ximian.com>
	 <1117698518.6458.21.camel@laptopd505.fenrus.org>
	 <1117698764.6833.26.camel@jenny.boston.ximian.com>
Content-Type: text/plain
Date: Thu, 02 Jun 2005 09:56:17 +0200
Message-Id: <1117698978.6458.23.camel@laptopd505.fenrus.org>
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


> I do thing that this is useful, though--at GUADEC I talked with some
> folks who really want to get at a good clock source, the same from both
> the kernel and user-space.

I'd love to see one (but preferably 2 or 3) users of this so that we can
figure out what a good interface would look like...


