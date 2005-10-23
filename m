Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932078AbVJWKpE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932078AbVJWKpE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Oct 2005 06:45:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932079AbVJWKpE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Oct 2005 06:45:04 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:40615 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932078AbVJWKpB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Oct 2005 06:45:01 -0400
Subject: Re: Understanding Linux addr space, malloc, and heap
From: Arjan van de Ven <arjan@infradead.org>
To: 7eggert@gmx.de
Cc: Kyle Moffett <mrmacman_g4@mac.com>, "Vincent W. Freeh" <vin@csc.ncsu.edu>,
       linux-kernel@vger.kernel.org
In-Reply-To: <E1ETdIF-0000h8-Iw@be1.lrz>
References: <505ru-8qi-1@gated-at.bofh.it> <505Lp-B4-81@gated-at.bofh.it>
	 <506QZ-2cH-3@gated-at.bofh.it> <5070Y-2qP-23@gated-at.bofh.it>
	 <507ac-2Cm-25@gated-at.bofh.it> <507NL-3Em-29@gated-at.bofh.it>
	 <507Xd-3QT-19@gated-at.bofh.it> <50xnU-7s2-37@gated-at.bofh.it>
	 <E1ETdIF-0000h8-Iw@be1.lrz>
Content-Type: text/plain
Date: Sun, 23 Oct 2005 12:44:47 +0200
Message-Id: <1130064287.2775.3.camel@laptopd505.fenrus.org>
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


> But even if Vincend makes the next malloc/free/whatever to be fubar,
> or if he made the world explode, mprotect is still required to report
> an error if the requested action failed.

but.. there's no proof yet that it failed...


