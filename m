Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262909AbVEGNJS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262909AbVEGNJS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 May 2005 09:09:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263094AbVEGNJS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 May 2005 09:09:18 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:1447 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262909AbVEGNJQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 May 2005 09:09:16 -0400
Subject: Re: [2.6 patch] drivers/net/ixgb/: possible cleanups
From: Arjan van de Ven <arjan@infradead.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: Ganesh Venkatesan <ganesh.venkatesan@gmail.com>,
       ayyappan.veeraiyan@intel.com, ganesh.venkatesan@intel.com,
       john.ronciak@intel.com, jgarzik@pobox.com, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <20050507123814.GJ3590@stusta.de>
References: <20050506211834.GM3590@stusta.de>
	 <5fc59ff3050506153523cd12dd@mail.gmail.com>
	 <1115468645.6388.37.camel@laptopd505.fenrus.org>
	 <20050507123814.GJ3590@stusta.de>
Content-Type: text/plain
Date: Sat, 07 May 2005 15:09:01 +0200
Message-Id: <1115471341.6388.41.camel@laptopd505.fenrus.org>
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


> I'm not sure whether Ganesh was really talking about license issues, or 
> whether the problem is that my patch #if 0's away code they use in other 
> non-GPL'ed drivers.

fair point, the solution for the later could be to use #ifndef __linux__
or something instead of #if 0


