Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261798AbVDEQfT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261798AbVDEQfT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 12:35:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261804AbVDEQfT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 12:35:19 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:46823 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261798AbVDEQfM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 12:35:12 -0400
Subject: RE: /proc on 2.4.21 & 2.6 kernels....
From: Arjan van de Ven <arjan@infradead.org>
To: Amanulla G <amanulla@india.hp.com>
Cc: linux-kernel@vger.kernel.org, jdp@india.hp.com
In-Reply-To: <200504051632.WAA05569@harvest.india.hp.com>
References: <200504051632.WAA05569@harvest.india.hp.com>
Content-Type: text/plain
Date: Tue, 05 Apr 2005 18:35:03 +0200
Message-Id: <1112718903.6275.75.camel@laptopd505.fenrus.org>
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

On Tue, 2005-04-05 at 21:52 +0530, Amanulla G wrote:
>  Hi, 
> Thanks for the mail.
> May be I didn't put my question correctly.
> On 2.4.21 based kernels /proc has got hidden directories which has got the
> thread related statistics.

I understood your question. 
However 2.4.21 kernels from kernel.org do not have such hidden
directories.

> My second part of question was:
> On 2.6 kernels, we have  /proc/<tgid>/task/xxx 
> My question is /proc/<tgid> stats reflect resource utilization of the
> threads it has created? 

yes afaik it's cumulative over the threads there.


