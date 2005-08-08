Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932157AbVHHRvZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932157AbVHHRvZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 13:51:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932156AbVHHRvZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 13:51:25 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:26303 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932098AbVHHRvY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 13:51:24 -0400
Subject: Re: Wireless support
From: Arjan van de Ven <arjan@infradead.org>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Denis Vlasenko <vda@ilport.com.ua>, abonilla@linuxwireless.org,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1123523298.15269.18.camel@mindpipe>
References: <1123442554.12766.17.camel@mindpipe>
	 <1123461574.4920.6.camel@localhost.localdomain>
	 <200508080931.59084.vda@ilport.com.ua> <1123523298.15269.18.camel@mindpipe>
Content-Type: text/plain
Date: Mon, 08 Aug 2005 19:51:16 +0200
Message-Id: <1123523476.3245.51.camel@laptopd505.fenrus.org>
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

On Mon, 2005-08-08 at 13:48 -0400, Lee Revell wrote:
> On Mon, 2005-08-08 at 09:31 +0300, Denis Vlasenko wrote:
> > On Monday 08 August 2005 03:39, Alejandro Bonilla Beeche wrote:
> > > On Sun, 2005-08-07 at 15:22 -0400, Lee Revell wrote:
> > > > Is the Linksys WUSB 54GS wireless adapter (FCCID Q87-WUSB54GS)
> > > > supported?
> > > 
> > > Normally, linksys doesn't care much about Linux and they won't even
> > > release info for a driver. Yeah, they have some open info for the WRT's
> > > but the adapters are normally usable with ndiswrapper or Linuxant
> > > driver.
> > 
> > The more I read this, the more I think about usefulness of blacklisting
> > ndiswrapper.
> 
> What's your reasoning?  The technical aspect of the argument is obvious
> (incompatible with 4K stacks) but the political side seems insolvable.
> Wouldn't this leave thousands of users with non working hardware?\

arguably it doesn't really work with ndiswrapper either; only most of
the time (due to windows having a 12kb stack)... and it's effectively a
binary only kernel module.

it also provides a discentive for vendors to provide real linux
drivers....

