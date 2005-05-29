Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261273AbVE2Hm1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261273AbVE2Hm1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 May 2005 03:42:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261272AbVE2Hm1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 May 2005 03:42:27 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:16536 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261273AbVE2HmW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 May 2005 03:42:22 -0400
Subject: Re: The values of gettimeofday() jumps.
From: Arjan van de Ven <arjan@infradead.org>
To: Liangchen Zheng <zlc@dream.eng.uci.edu>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <000201c563ee$eed993d0$85a4c380@dream.eng.uci.edu>
References: <000201c563ee$eed993d0$85a4c380@dream.eng.uci.edu>
Content-Type: text/plain
Date: Sun, 29 May 2005 09:42:18 +0200
Message-Id: <1117352538.6278.0.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
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

On Sat, 2005-05-28 at 18:37 -0700, Liangchen Zheng wrote:
> Hello,
> 	We have several SMP machines (Tyan Tiger MPX motherboard, 2
> AthlonMP 1900+ CPU, linux-2.4.21-20.EL).  When running some time
> sensitive programs, I observed that the values of gettimeofday () jumped
> sometimes on a couple of machines (other machines are fine), from
> several hundreds milliseconds to a couple of seconds. 

try "notsc" as boot option


