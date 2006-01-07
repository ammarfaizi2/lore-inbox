Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030602AbWAGVv0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030602AbWAGVv0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 16:51:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030603AbWAGVvZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 16:51:25 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:56279 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1030602AbWAGVvY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 16:51:24 -0500
Subject: Re: [2.6 patch] OCFS2: __init / __exit problem
From: Arjan van de Ven <arjan@infradead.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: Mark Fasheh <mark.fasheh@oracle.com>, kurt.hackel@oracle.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060107214947.GW3774@stusta.de>
References: <20060107132008.GE820@lug-owl.de>
	 <20060107190702.GT3774@stusta.de>
	 <20060107213821.GD3313@ca-server1.us.oracle.com>
	 <20060107214947.GW3774@stusta.de>
Content-Type: text/plain
Date: Sat, 07 Jan 2006 22:51:17 +0100
Message-Id: <1136670678.2936.46.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.8 (--)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (-2.8 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> This is the common problem that such error paths are only used once 
> every dozen years and therefore get no real testing coverage...


Rusty presented some brilliant tool for this at OLS this year... I bet
that could be used for filesystems as well (Rusty uses it for netfilter
testing)

