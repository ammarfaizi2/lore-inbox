Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261676AbUK2LWG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261676AbUK2LWG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 06:22:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261677AbUK2LWF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 06:22:05 -0500
Received: from canuck.infradead.org ([205.233.218.70]:33029 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S261676AbUK2LUL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 06:20:11 -0500
Subject: Re: [ANNOUNCE 0/7] Diskdump 1.0 Release
From: Arjan van de Ven <arjan@infradead.org>
To: Takao Indoh <indou.takao@soft.fujitsu.com>
Cc: linux-kernel@vger.kernel.org, lkdump-develop@lists.sourceforge.net
In-Reply-To: <3AC4D5FF1413D5indou.takao@soft.fujitsu.com>
References: <3AC4D5FF1413D5indou.takao@soft.fujitsu.com>
Content-Type: text/plain
Message-Id: <1101727191.2814.52.camel@laptop.fenrus.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.dwmw2.1) 
Date: Mon, 29 Nov 2004 12:19:52 +0100
Content-Transfer-Encoding: 7bit
X-Spam-Score: 3.7 (+++)
X-Spam-Report: SpamAssassin version 2.63 on canuck.infradead.org summary:
	Content analysis details:   (3.7 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
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

On Mon, 2004-11-29 at 19:35 +0900, Takao Indoh wrote:
> Hi, all!
> I release diskdump 1.0 for kernel 2.6.9. It can be downloaded from
> the following site. Please feel free to use it!
>    http://sourceforge.net/projects/lkdump
> 
> Diskdump project is a joint development of RedHat and Fujitsu, and I'd 

I think the company name is spelled Red Hat ;)

> like to express my gratitude to a RedHat developers for many comments
> and advices.

Can you explain to me why anyone would want to use this invasive patch 
(it requires all drivers to change) instead of the kexec-dump approach? The
kexec-dump approach appears on first sight to be far cleaner and far more powerful,
so there must be a reason this work was done regardless of that.. I'm curious 
what those reasons are, eg what's the advantage ???


