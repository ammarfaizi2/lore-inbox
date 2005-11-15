Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751394AbVKOJqJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751394AbVKOJqJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 04:46:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751403AbVKOJqJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 04:46:09 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:13964 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751394AbVKOJqI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 04:46:08 -0500
Subject: Re: [2.6 patch] i386: always use 4k stacks
From: Arjan van de Ven <arjan@infradead.org>
To: Bernd Petrovitsch <bernd@firmix.at>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1132047119.27192.14.camel@tara.firmix.at>
References: <58XuN-29u-17@gated-at.bofh.it> <58XuN-29u-19@gated-at.bofh.it>
	 <58XuN-29u-21@gated-at.bofh.it> <58XuN-29u-23@gated-at.bofh.it>
	 <58XuN-29u-25@gated-at.bofh.it> <58XuN-29u-15@gated-at.bofh.it>
	 <58YAt-3Fs-5@gated-at.bofh.it> <58ZGo-5ba-13@gated-at.bofh.it>
	 <5909m-5JB-5@gated-at.bofh.it> <43795F35.3050904@shaw.ca>
	 <43795C55.9080305@wolfmountaingroup.com>  <43796489.8090500@shaw.ca>
	 <1132047119.27192.14.camel@tara.firmix.at>
Content-Type: text/plain
Date: Tue, 15 Nov 2005 10:45:51 +0100
Message-Id: <1132047951.2822.11.camel@laptopd505.fenrus.org>
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


> And yes, you need ndiswrapper for almost all of the WLAN drivers since
> there is no documentation of them.

you're wrong.


documentation for broadcom wireless:
http://bcm-specs.sipsolutions.net/
embrionic driver based on this spec:
http://bcm43xx.berlios.de/

driver for atheros wireless is nearly done:
http://www.selenic.com/pipermail/kernel-mentors/2005-August/000351.html


now if people started to help these folks instead of crying for
ndiswrapper binary solutions maybe those drivers will be finished
quicker.

