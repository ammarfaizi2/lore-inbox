Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261571AbVBWU7A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261571AbVBWU7A (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 15:59:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261577AbVBWU7A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 15:59:00 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:30608 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261571AbVBWUyH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 15:54:07 -0500
Subject: Re: kernel BUG at mm/rmap.c:483!
From: Arjan van de Ven <arjan@infradead.org>
To: "Ammar T. Al-Sayegh" <ammar@kunet.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <009d01c519e8$166768b0$7101a8c0@shrugy>
References: <009d01c519e8$166768b0$7101a8c0@shrugy>
Content-Type: text/plain
Date: Wed, 23 Feb 2005 21:54:00 +0100
Message-Id: <1109192040.6290.108.camel@laptopd505.fenrus.org>
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

On Wed, 2005-02-23 at 15:41 -0500, Ammar T. Al-Sayegh wrote:
> Hi All,
> 
> I recently installed Fedora RC3 on a new server.
> The kernel is 2.6.10-1.741_FC3smp. The server
> crashes every few days. When I examine /var/log/messages,
> I find the following line just before the crash:
> 
> Feb 22 23:50:35 hostname kernel: ------------[ cut here ]------------
> Feb 22 23:50:35 hostname kernel: kernel BUG at mm/rmap.c:483!
> 
> No further debug lines are given to diagnose the
> source of the 
no oops at all?

which modules are you using?

