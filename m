Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965186AbVHPKJh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965186AbVHPKJh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 06:09:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965188AbVHPKJh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 06:09:37 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:65164 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S965186AbVHPKJg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 06:09:36 -0400
Subject: Re: Defination of Flag CONFIG_DEBUG_SPINLOCK_SLEEP in AS4 UP1
From: Arjan van de Ven <arjan@infradead.org>
To: shahid.shaikh@patni.com
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <00a501c5a24a$4339aca0$11051aac@pcp41116>
References: <00a501c5a24a$4339aca0$11051aac@pcp41116>
Content-Type: text/plain
Date: Tue, 16 Aug 2005 12:09:26 +0200
Message-Id: <1124186966.3215.29.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 2.9 (++)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (2.9 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	2.8 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-08-16 at 15:37 +0530, shahid shaikh wrote:
> Hi all,
> While doing insmod for a psuedo driver, kernel is dumping a stack because
> sleep function is called.
> My init_module function for psuedo driver calls add_disk to register admin
> device.
> In add_disk(), kernel is allocating memory using kmalloc with flag
> GFP_KERNEL. This is hardcoded in kernel code for add_disk.

you forgot to put an URL with your sourcecode in your email




