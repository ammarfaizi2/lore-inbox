Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261935AbUKPIMP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261935AbUKPIMP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 03:12:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261936AbUKPIMP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 03:12:15 -0500
Received: from canuck.infradead.org ([205.233.218.70]:18952 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S261935AbUKPIMJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 03:12:09 -0500
Subject: Re: [patch] prefer TSC over PM Timer
From: Arjan van de Ven <arjan@infradead.org>
To: john stultz <johnstul@us.ibm.com>
Cc: dean gaudet <dean-list-linux-kernel@arctic.org>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1100569104.21267.58.camel@cog.beaverton.ibm.com>
References: <Pine.LNX.4.61.0411151531590.22091@twinlark.arctic.org>
	 <1100569104.21267.58.camel@cog.beaverton.ibm.com>
Content-Type: text/plain
Message-Id: <1100592718.2811.8.camel@laptop.fenrus.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.dwmw2.1) 
Date: Tue, 16 Nov 2004 09:11:58 +0100
Content-Transfer-Encoding: 7bit
X-Spam-Score: 3.7 (+++)
X-Spam-Report: SpamAssassin version 2.63 on canuck.infradead.org summary:
	Content analysis details:   (3.7 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	1.1 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?ip=80.57.133.107>]
	2.5 RCVD_IN_DYNABLOCK      RBL: Sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	0.1 RCVD_IN_SORBS          RBL: SORBS: sender is listed in SORBS
	[80.57.133.107 listed in dnsbl.sorbs.net]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> While there are a great number of systems that can use the TSC, cpufreq
> scaling laptops, and a number of SMP and NUMA systems cannot use it as a
> time source. 

please don't drag cpufreq into this; cpufreq adjusts this timer on
frequency changes just fine.



