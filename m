Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262107AbVANT6A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262107AbVANT6A (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 14:58:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262086AbVANT5m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 14:57:42 -0500
Received: from canuck.infradead.org ([205.233.218.70]:9993 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S262061AbVANT5g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 14:57:36 -0500
Subject: Re: Poor responsiveness during disk I/O
From: Arjan van de Ven <arjan@infradead.org>
To: Shaun Jackman <sjackman@gmail.com>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <7f45d9390501141121269b42b2@mail.gmail.com>
References: <7f45d9390501141121269b42b2@mail.gmail.com>
Content-Type: text/plain
Date: Fri, 14 Jan 2005 20:57:30 +0100
Message-Id: <1105732650.6042.50.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 4.1 (++++)
X-Spam-Report: SpamAssassin version 2.63 on canuck.infradead.org summary:
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
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-01-14 at 11:21 -0800, Shaun Jackman wrote:
> My system is unresponsive and nearly unusable during period of high
> disk I/O. hdparm reports it's using UDMA5 (ATA100), so it looks like
> everything's up and running. I have a nForce 220-D motherboard
> (A7N266-VM), a new 160 GB Maxtor ATA133 drive, and an 80 wire IDE
> cable. I've compiled the amd74xx driver into the kernel.
> 
> ATA100 suggests a maximum throughput of 100 MB/s. What I should I
> expect to see with hdparm -t?   I'm seeing 40 MB/s.
> 
> Please cc me in your reply. Thanks,


you report a problem to the kernel mailing list suggesting the kernel
does something suboptimal, but you entirely forgot to mention which
kernel you are using ;) Could you fix that ommision please?

