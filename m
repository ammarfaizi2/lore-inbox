Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751206AbVLCId1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751206AbVLCId1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Dec 2005 03:33:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751211AbVLCId0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Dec 2005 03:33:26 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:59530 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751206AbVLCId0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Dec 2005 03:33:26 -0500
Subject: Re: copy_from_user/copy_to_user question
From: Arjan van de Ven <arjan@infradead.org>
To: Vinay Venkataraghavan <raghavanvinay@yahoo.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Al Viro <viro@ftp.linux.org.uk>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20051203021154.30862.qmail@web32113.mail.mud.yahoo.com>
References: <20051203021154.30862.qmail@web32113.mail.mud.yahoo.com>
Content-Type: text/plain
Date: Sat, 03 Dec 2005 09:33:09 +0100
Message-Id: <1133598789.22170.4.camel@laptopd505.fenrus.org>
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


> The piece of code that I am talking about is part of a
> driver code. Unfortunately I am not at liberty to
> divulge the name of the company. So in the driver then
> are not using copy_to_user and copy_from_user. That is
> what puzzles me. Moreover, where they are using these
> functions they use memcpy which is a big security
> risk.

I guess this is why you're not allowed to mention it... they'd be all
over bugtraq..

thank god for open source so that 1) customers can see the quality and
2) everyone can fix it....

