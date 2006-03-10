Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932297AbWCJHwX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932297AbWCJHwX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 02:52:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932328AbWCJHwW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 02:52:22 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:52642 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932297AbWCJHwW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 02:52:22 -0500
Subject: Re: [PATCH 00/03] Unmapped: Separate unmapped and mapped pages
From: Arjan van de Ven <arjan@infradead.org>
To: Magnus Damm <magnus@valinux.co.jp>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
In-Reply-To: <20060310034412.8340.90939.sendpatchset@cherry.local>
References: <20060310034412.8340.90939.sendpatchset@cherry.local>
Content-Type: text/plain
Date: Fri, 10 Mar 2006 08:52:18 +0100
Message-Id: <1141977139.2876.15.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Apply on top of 2.6.16-rc5.
> 
> Comments?


my big worry with a split LRU is: how do you keep fairness and balance
between those LRUs? This is one of the things that made the 2.4 VM suck
really badly, so I really wouldn't want this bad...

