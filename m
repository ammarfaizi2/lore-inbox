Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261953AbVBSV35@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261953AbVBSV35 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Feb 2005 16:29:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261955AbVBSV34
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Feb 2005 16:29:56 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:18617 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261953AbVBSV3z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Feb 2005 16:29:55 -0500
Subject: Re: updated list of unused kernel exports posted
From: Arjan van de Ven <arjan@infradead.org>
To: linux-kernel@vger.kernel.org
In-Reply-To: <1108847674.6304.158.camel@laptopd505.fenrus.org>
References: <1108847674.6304.158.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Date: Sat, 19 Feb 2005 22:29:51 +0100
Message-Id: <1108848592.6304.162.camel@laptopd505.fenrus.org>
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

On Sat, 2005-02-19 at 22:14 +0100, Arjan van de Ven wrote:
> Hi,
> 
> an updated list of currently unused-on-i386 kernel exports is now posted

Russell asked me to clarify this: symbols on this list may well be used
on other architectures than i386; before sending patches to remove them
please use grep to make sure it's really globally unused...


