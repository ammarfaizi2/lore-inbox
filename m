Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751558AbWHTVNE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751558AbWHTVNE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Aug 2006 17:13:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751471AbWHTVNE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Aug 2006 17:13:04 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:55745 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751436AbWHTVND (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Aug 2006 17:13:03 -0400
Subject: Re: [PATCH] getsockopt() early argument sanity checking
From: Arjan van de Ven <arjan@infradead.org>
To: Willy Tarreau <w@1wt.eu>
Cc: David Miller <davem@davemloft.net>, mb@bu3sch.de, solar@openwall.com,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
In-Reply-To: <20060820203559.GT602@1wt.eu>
References: <20060819234806.GB27115@1wt.eu>
	 <200608200205.20876.mb@bu3sch.de> <20060820004307.GD27115@1wt.eu>
	 <20060820.124427.74745779.davem@davemloft.net>
	 <20060820203559.GT602@1wt.eu>
Content-Type: text/plain
Organization: Intel International BV
Date: Sun, 20 Aug 2006 23:12:52 +0200
Message-Id: <1156108373.23756.74.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> We're not assuming they're broken. When some code is maintained by many people
> and when conventions differ between similar functions (eg: setsockopt does
> the check at top level and getsockopt in the leaves),

thats not something you want to fix in 2.4 though ;)

it may be worth considering for 2.6 of course.

