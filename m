Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262544AbVCJMLY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262544AbVCJMLY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 07:11:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262540AbVCJMLJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 07:11:09 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:15768 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262546AbVCJMKv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 07:10:51 -0500
Subject: Re: [PATCH] make st seekable again
From: Arjan van de Ven <arjan@infradead.org>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Kai Makisara <Kai.Makisara@kolumbus.fi>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.3.96.1050310064102.10287B-100000@gatekeeper.tmr.com>
References: <Pine.LNX.3.96.1050310064102.10287B-100000@gatekeeper.tmr.com>
Content-Type: text/plain
Date: Thu, 10 Mar 2005 13:10:40 +0100
Message-Id: <1110456640.6291.79.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 4.1 (++++)
X-Spam-Report: SpamAssassin version 2.63 on pentafluge.infradead.org summary:
	Content analysis details:   (4.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.3 RCVD_NUMERIC_HELO      Received: contains a numeric HELO
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

>  critical user data.
> 
> In other words, it should work correctly or not at all. At the least this
> should be a config option, like UNSAFE_TAPE_POSITIONING or some such.
> And show the option if the build includes BROKEN features. That should put
> the decision where it belongs and clarify the possible failures.

CONFIG_SECURITY_HOLES doesn't make sense.
Better to just fix the security holes instead.


