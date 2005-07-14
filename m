Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262943AbVGNHpb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262943AbVGNHpb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 03:45:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262946AbVGNHpb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 03:45:31 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:32916 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262943AbVGNHp3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 03:45:29 -0400
Subject: Re: Thread_Id
From: Arjan van de Ven <arjan@infradead.org>
To: rvk@prodmail.net
Cc: Robert Hancock <hancockr@shaw.ca>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <42D5F934.6000603@prodmail.net>
References: <4mfcK-UT-25@gated-at.bofh.it> <4mUJ1-5ZG-23@gated-at.bofh.it>
	 <42CB465E.6080104@shaw.ca>  <42D5F934.6000603@prodmail.net>
Content-Type: text/plain
Date: Thu, 14 Jul 2005 09:45:03 +0200
Message-Id: <1121327103.3967.14.camel@laptopd505.fenrus.org>
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

On Thu, 2005-07-14 at 11:03 +0530, RVK wrote:
> Robert Hancock wrote:
> 
> > RVK wrote:
> >
> >> Can anyone suggest me how to get the threadId using 2.6.x kernels.
> >> pthread_self() does not work and returns some -ve integer.
> >
> >
> > What do you mean, negative integer? It's not an integer, it's a
> > pthread_t, you're not even supposed to look at it..
> 
> What is pthread_t inturn defined to ? pthread_self for 2.4.x thread 
> libraries return +ve number(as u have a objection me calling it as 
> integer :-))

it doesn't return a number it returns a pointer ;) or a floating point
number. You don't know :)

what it returns is a *cookie*. A cookie that you can only use to pass
back to various pthread functions.


