Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262503AbVCJKSx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262503AbVCJKSx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 05:18:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262501AbVCJKSw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 05:18:52 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:33174 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262508AbVCJKR7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 05:17:59 -0500
Subject: Re: [RFC] -stable, how it's going to work.
From: Arjan van de Ven <arjan@infradead.org>
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
       Chris Wright <chrisw@osdl.org>, torvalds@osdl.org,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <16944.6867.858907.990990@cse.unsw.edu.au>
References: <20050309072833.GA18878@kroah.com>
	 <16944.6867.858907.990990@cse.unsw.edu.au>
Content-Type: text/plain
Date: Thu, 10 Mar 2005 11:17:51 +0100
Message-Id: <1110449872.6291.64.camel@laptopd505.fenrus.org>
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

On Thu, 2005-03-10 at 21:00 +1100, Neil Brown wrote:
> On Tuesday March 8, greg@kroah.com wrote:
> > So here's a first cut at how this 2.6 -stable release process is going
> > to work that Chris and I have come up with.  Does anyone have any
> > problems/issues/questions with this?
> 
> One rule that I thought would make sense, but that I don't see listed
> is:
> 
>  - must fix a regression
> 
> If some problem was in 2.6.X and is still there in 2.6.X+1, then there
> is no great rush to fix it for 2.6.(X+1).1, it can wait for 2.6.(X+2).

this is tricky. I mean, what if it's a datacorruption thing? Sure older
kernels may have it too... yet at the same time it'd be nice to get it
fixed. And once you go down this slipperly slope you end up with the
original ruleset again, eg it must be "somehow relatively important".


