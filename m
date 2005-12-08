Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932181AbVLHPjM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932181AbVLHPjM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 10:39:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932186AbVLHPjM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 10:39:12 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:61923 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932181AbVLHPjK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 10:39:10 -0500
Subject: Re: How to enable/disable security features on mmap() ?
From: Arjan van de Ven <arjan@infradead.org>
To: Emmanuel Fleury <emmanuel.fleury@labri.fr>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <4398516F.1020101@labri.fr>
References: <43983EBE.2080604@labri.fr>
	 <1134051272.2867.63.camel@laptopd505.fenrus.org>
	 <43984154.5050502@labri.fr>  <43984595.1090406@labri.fr>
	 <1134053349.2867.65.camel@laptopd505.fenrus.org> <4398493E.50508@labri.fr>
	 <Pine.LNX.4.61.0512081011020.32448@chaos.analogic.com>
	 <4398516F.1020101@labri.fr>
Content-Type: text/plain
Date: Thu, 08 Dec 2005 16:39:07 +0100
Message-Id: <1134056348.2867.76.camel@laptopd505.fenrus.org>
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


> Well, there are some other strangeness (especially when running on a
> x86_64 architecture). See:

x86-64 does not have all the randomisation patches yet in mainline,
waiting on Andi to approve ;)

> Moreover, the libc location (and all other dynamic libs) is not
> randomized under x86_64. I have no explanation for this. :-/

see above; in addition prelink may be interfering with this.



