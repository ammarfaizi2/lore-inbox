Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261644AbVCVSUD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261644AbVCVSUD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 13:20:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261628AbVCVSSR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 13:18:17 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:43210 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261621AbVCVSQ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 13:16:58 -0500
Subject: Re: 2.6.12-rc1-mm1: REISER4_FS <-> 4KSTACKS
From: Arjan van de Ven <arjan@infradead.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, Hans Reiser <reiser@namesys.com>,
       linux-kernel@vger.kernel.org, reiserfs-dev@namesys.com
In-Reply-To: <20050322171340.GE1948@stusta.de>
References: <20050321025159.1cabd62e.akpm@osdl.org>
	 <20050322171340.GE1948@stusta.de>
Content-Type: text/plain
Date: Tue, 22 Mar 2005 19:16:49 +0100
Message-Id: <1111515410.7096.93.camel@laptopd505.fenrus.org>
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

On Tue, 2005-03-22 at 18:13 +0100, Adrian Bunk wrote:
> Hi Hans,
> 
> REISER4_FS is the only option with a dependency on !4KSTACKS which is 
> bad since 8 kB stacks on i386 won't stay forever.
> 
> Could fix the problems with 4 kB stacks?

I'd be interested to find out what the problem is as well; after all
even with 8Kb stacks your net available stack is somewhere in the 5Kb
range anyway... so you're really close to the edge there.


