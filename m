Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751194AbVK3MM3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751194AbVK3MM3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 07:12:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751198AbVK3MM3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 07:12:29 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:48291 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751194AbVK3MM2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 07:12:28 -0500
Subject: Re: [RFC] [PATCH] Adding ctrl-o sysrq hack support to 8250 driver
From: Arjan van de Ven <arjan@infradead.org>
To: Sachin Sant <sachinp@in.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>, ssant@in.ibm.com
In-Reply-To: <438D8A3A.9030400@in.ibm.com>
References: <438D8A3A.9030400@in.ibm.com>
Content-Type: text/plain
Date: Wed, 30 Nov 2005 13:12:23 +0100
Message-Id: <1133352743.2825.27.camel@laptopd505.fenrus.org>
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

On Wed, 2005-11-30 at 16:47 +0530, Sachin Sant wrote:
> The following patch will allow a user to use sysrq keys over a serial 
> console using the ctrl-o key sequence. This is similar to functionality 
> provided by the hvc console drivers on PPC boxes.

is sending a BRK over serial not enough? (the existing method)
minicom for sure can send that.. I'm sure all other terminal emulator
apps can as well.


