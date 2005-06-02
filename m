Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261594AbVFBH3e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261594AbVFBH3e (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Jun 2005 03:29:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261595AbVFBH3e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Jun 2005 03:29:34 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:39916 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261594AbVFBH3c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Jun 2005 03:29:32 -0400
Subject: Re: Accessing monotonic clock from modules
From: Arjan van de Ven <arjan@infradead.org>
To: Mikael Starvik <mikael.starvik@axis.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <BFECAF9E178F144FAEF2BF4CE739C66801B7645C@exmail1.se.axis.com>
References: <BFECAF9E178F144FAEF2BF4CE739C66801B7645C@exmail1.se.axis.com>
Content-Type: text/plain
Date: Thu, 02 Jun 2005 09:29:29 +0200
Message-Id: <1117697369.6458.16.camel@laptopd505.fenrus.org>
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

On Thu, 2005-06-02 at 08:36 +0200, Mikael Starvik wrote:
> We would like to get the posix monotonic clock from a loadable module.
> Would a patch to make do_posix_clock_monotonic_gettime exported ok or
> should we do it in some other way?

how about making this a _GPL export?

