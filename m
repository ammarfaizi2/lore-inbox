Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261931AbVANJql@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261931AbVANJql (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 04:46:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261932AbVANJql
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 04:46:41 -0500
Received: from canuck.infradead.org ([205.233.218.70]:4107 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S261931AbVANJqj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 04:46:39 -0500
Subject: Re: Linux kernel 2.4.20-18.7smp bug
From: Arjan van de Ven <arjan@infradead.org>
To: jike <jike@allyes.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <200501140901.j0E91Lk07957@adf141.allyes.com>
References: <200501140901.j0E91Lk07957@adf141.allyes.com>
Content-Type: text/plain
Date: Fri, 14 Jan 2005 10:46:33 +0100
Message-Id: <1105695993.6080.25.camel@laptopd505.fenrus.org>
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

On Fri, 2005-01-14 at 17:17 +0800, jike wrote:
> Hi,all
> 
> 	I use the RedHat Linux 7.3 , kernel version is 2.4.20-18.7smp. Today, i find one bug info in /var/log/message, the bug info as following:
>   
> Jan 13 11:02:47 zjip142 kernel: EIP:    0010:[<f883fc95>]    Tainted: P
> Jan 13 11:02:47 zjip142 kernel: EFLAGS: 00010286

you are running a very old kernel, and you are using at least one binary
only module... I don't think linux-kernel is the right forum for such an
issue ;)


