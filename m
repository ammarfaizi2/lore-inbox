Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262648AbVBYICR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262648AbVBYICR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Feb 2005 03:02:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262649AbVBYICR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Feb 2005 03:02:17 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:13998 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262648AbVBYICN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Feb 2005 03:02:13 -0500
Subject: Re: [2.6 patch] unexport do_settimeofday
From: Arjan van de Ven <arjan@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org
In-Reply-To: <20050224212448.367af4be.akpm@osdl.org>
References: <20050224233742.GR8651@stusta.de>
	 <20050224212448.367af4be.akpm@osdl.org>
Content-Type: text/plain
Date: Fri, 25 Feb 2005 09:02:04 +0100
Message-Id: <1109318525.6290.32.camel@laptopd505.fenrus.org>
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

On Thu, 2005-02-24 at 21:24 -0800, Andrew Morton wrote:
> Adrian Bunk <bunk@stusta.de> wrote:
> >
> > 
> >  I haven't found any possible modular usage of do_settimeofday in the 
> >  kernel.
> 
> Please,
> 
> - Add deprecated_if_module
> 
> - Use it for do_settimeofday()
> 
> - Add do_settimeofday to Documentation/feature-removal-schedule.txt
> -

for _set_ time of day? I really can't imagine anyone messing with that.
_get_... sure. but set???


