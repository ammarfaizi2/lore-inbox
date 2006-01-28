Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422839AbWA1TAY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422839AbWA1TAY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jan 2006 14:00:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422833AbWA1TAY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jan 2006 14:00:24 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:32197
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1422774AbWA1TAX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jan 2006 14:00:23 -0500
Date: Sat, 28 Jan 2006 11:00:43 -0800 (PST)
Message-Id: <20060128.110043.83251114.davem@davemloft.net>
To: ashutosh.naik@gmail.com
Cc: linux-kernel@vger.kernel.org, davem@redhat.com, kuznet@ms2.inr.ac.ru,
       akpm@osdl.org, linux-net@vger.kernel.org
Subject: Re: [PATCH] net/core/flow.c CONFIG_SMP Fix in
 flow_cache_flush(void)
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <81083a450601280444y683a3899h12054edfe610a51f@mail.gmail.com>
References: <81083a450601280444y683a3899h12054edfe610a51f@mail.gmail.com>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ashutosh Naik <ashutosh.naik@gmail.com>
Date: Sat, 28 Jan 2006 18:14:37 +0530

> This patch fixes a warning in the function flow_cache_flush(), where
> the the function smp_call_function is entered even when CONFIG_SMP is
> not defined
> 
> Signed-off-by: Ashutosh Naik <ashutosh.naik@gmail.com>

There was a long thread about how to fix this problem
properly on linux-kernel a month or two ago.
