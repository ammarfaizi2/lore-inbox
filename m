Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932217AbWGBRjj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932217AbWGBRjj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jul 2006 13:39:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751442AbWGBRjj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jul 2006 13:39:39 -0400
Received: from gw03.mail.saunalahti.fi ([195.197.172.111]:46526 "EHLO
	gw03.mail.saunalahti.fi") by vger.kernel.org with ESMTP
	id S1751387AbWGBRjh (ORCPT <rfc822;<linux-kernel@vger.kernel.org>>);
	Sun, 2 Jul 2006 13:39:37 -0400
From: Jan Knutar <jk-lkml@sci.fi>
To: John Heffner <jheffner@psc.edu>
Subject: Re: 2.6.17: networking bug??
Date: Sun, 2 Jul 2006 20:39:06 +0300
User-Agent: KMail/1.6.2
Cc: Mark Lord <lkml@rtr.ca>, Linux Kernel <linux-kernel@vger.kernel.org>,
       netdev@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       davem@davemloft.net
References: <448EC6F3.3060002@rtr.ca> <448EF45B.2080601@rtr.ca> <448EF85E.50405@psc.edu>
In-Reply-To: <448EF85E.50405@psc.edu>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200607022039.06166.jk-lkml@sci.fi>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 13 June 2006 20:39, John Heffner wrote:

> The best thing you can do is try to find this broken box and inform its 
> owner that it needs to be fixed.  (If you can find out what it is, I'd 
> be interested to know.)  In the meantime, disabling window scaling will 
> work around the problem for you.

I was bit by this "networking bug" too. The broken box turned out to be
the OpenBSD box I was trying to connect to.

The owner removed scrub from pf.conf, and connectivity was restored.
