Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932217AbVLANdN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932217AbVLANdN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 08:33:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932232AbVLANdN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 08:33:13 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:11410 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932217AbVLANdM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 08:33:12 -0500
Subject: Re: loadavg always equal or above 1.00 - how to explain?
From: Arjan van de Ven <arjan@infradead.org>
To: Tomasz Chmielewski <mangoo@wpkg.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <438EF3E5.5080709@wpkg.org>
References: <438EE515.1080001@wpkg.org>
	 <1133440871.2853.36.camel@laptopd505.fenrus.org>
	 <438EF3E5.5080709@wpkg.org>
Content-Type: text/plain
Date: Thu, 01 Dec 2005 14:33:10 +0100
Message-Id: <1133443990.2853.44.camel@laptopd505.fenrus.org>
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


> Now I have to figure out what CROND was doing...
> 
if it does it again, do that echo t > /proc/sysrq-trigger
and look for "crond" in the output, that will give a kernel backtrace of
where crond was.

> Does ps always show processes in D state in CAPITAL letters?
> 

hmm I never noticed that before, but then again "ps" may be undergoing
innovations ;)



