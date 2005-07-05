Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261756AbVGEIqO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261756AbVGEIqO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Jul 2005 04:46:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261751AbVGEIqN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Jul 2005 04:46:13 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:8068 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261776AbVGEIij (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 04:38:39 -0400
Subject: Re: LKM function call on kernel function call?
From: Arjan van de Ven <arjan@infradead.org>
To: S <talk2sumit@gmail.com>
Cc: linux-kernel@vger.kernel.org,
       linux prg <linux-c-programming@vger.kernel.org>
In-Reply-To: <1458d9610507050123124d6cb@mail.gmail.com>
References: <1458d9610507050123124d6cb@mail.gmail.com>
Content-Type: text/plain
Date: Tue, 05 Jul 2005 10:38:26 +0200
Message-Id: <1120552708.3180.29.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
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

On Tue, 2005-07-05 at 16:23 +0800, S wrote:
> Is it possible to code a loadable module having function1(), which
> would be called, everytime a particular function of the kernel is
> called? If not, atleast a way this could be done without re-compiling
> the whole kernel and rebooting the system?

why don't you want to compile the whole kernel ? You have the source
code and it for sure is the easiest way to add this (debug?) hack...


