Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261519AbVDCGSU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261519AbVDCGSU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Apr 2005 01:18:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261520AbVDCGST
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Apr 2005 01:18:19 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:43697 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261519AbVDCGSR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Apr 2005 01:18:17 -0500
Subject: Re: [RFC,PATCH 1/4] Add deprecated_for_modules
From: Arjan van de Ven <arjan@infradead.org>
To: paulmck@us.ibm.com
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050403061135.GA1641@us.ibm.com>
References: <20050403061135.GA1641@us.ibm.com>
Content-Type: text/plain
Date: Sun, 03 Apr 2005 08:18:11 +0200
Message-Id: <1112509091.6274.2.camel@laptopd505.fenrus.org>
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

On Sat, 2005-04-02 at 22:11 -0800, Paul E. McKenney wrote:
> Add a deprecated_for_modules macro that allows symbols to be


> +#ifdef MODULE
> +#define deprecated_for_modules __deprecated
> +#else
> +#define deprecated_for_modules
> +#endif
> +

how about also starting it with __ like __deprecated is ?

