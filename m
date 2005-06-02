Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261601AbVFBHss@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261601AbVFBHss (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Jun 2005 03:48:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261603AbVFBHss
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Jun 2005 03:48:48 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:60140 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261601AbVFBHsq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Jun 2005 03:48:46 -0400
Subject: Re: Accessing monotonic clock from modules
From: Arjan van de Ven <arjan@infradead.org>
To: Robert Love <rml@novell.com>
Cc: Mikael Starvik <mikael.starvik@axis.com>, linux-kernel@vger.kernel.org
In-Reply-To: <1117698045.6833.16.camel@jenny.boston.ximian.com>
References: <BFECAF9E178F144FAEF2BF4CE739C66801B7645C@exmail1.se.axis.com>
	 <1117697423.6458.18.camel@laptopd505.fenrus.org>
	 <1117698045.6833.16.camel@jenny.boston.ximian.com>
Content-Type: text/plain
Date: Thu, 02 Jun 2005 09:48:38 +0200
Message-Id: <1117698518.6458.21.camel@laptopd505.fenrus.org>
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

On Thu, 2005-06-02 at 03:40 -0400, Robert Love wrote:
> On Thu, 2005-06-02 at 09:30 +0200, Arjan van de Ven wrote:
> > On Thu, 2005-06-02 at 08:36 +0200, Mikael Starvik wrote:
> > > We would like to get the posix monotonic clock from a loadable module.
> > > Would a patch to make do_posix_clock_monotonic_gettime exported ok or
> > > should we do it in some other way?
> > > 
> > > /Mikael
> > 
> > also... when are you going to get this module merged?
> > (exporting things without the module going into kernel.org shouldn't be
> > done imo... it makes it harder to change internals and causes overhead
> > for all kernel users)
> 
> And if we are going to make it an official interface, does it have to be
> called "do_posix_clock_monotonic_gettime" ?  Perhaps a more
> export-friendly name?

agreed.

well maybe it doesn't have such a name since it isn't intended as such
interface....


