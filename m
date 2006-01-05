Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752175AbWAET3j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752175AbWAET3j (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 14:29:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752176AbWAET3i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 14:29:38 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:3242 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1752175AbWAET3h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 14:29:37 -0500
Subject: Re: [patch] remove unused acct variables from task_struct
From: Arjan van de Ven <arjan@infradead.org>
To: Jay Lan <jlan@engr.sgi.com>
Cc: Jes Sorensen <jes@trained-monkey.org>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <43BD6FBA.6070805@engr.sgi.com>
References: <17340.62497.275248.207740@jaguar.mkp.net>
	 <43BD6FBA.6070805@engr.sgi.com>
Content-Type: text/plain
Date: Thu, 05 Jan 2006 20:29:30 +0100
Message-Id: <1136489371.2920.58.camel@laptopd505.fenrus.org>
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

On Thu, 2006-01-05 at 11:12 -0800, Jay Lan wrote:
> Jes Sorensen wrote:
> > This patch removes three acct related variables from struct
> > task_struct which are no longer in use. Their values were calculated
> > in acct_update_integrals, but never read back by anything.
> 
> Please don't. I will send in a patch to display those collected
> acct data via proc fs soon. We need those information.

how soon? this week?
(just wondering how long this currently-useless stuff is there already)

