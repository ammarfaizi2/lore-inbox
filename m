Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261373AbVFBLPw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261373AbVFBLPw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Jun 2005 07:15:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261376AbVFBLPw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Jun 2005 07:15:52 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:62081 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261373AbVFBLPr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Jun 2005 07:15:47 -0400
Subject: RE: Accessing monotonic clock from modules
From: Arjan van de Ven <arjan@infradead.org>
To: Mikael Starvik <mikael.starvik@axis.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <BFECAF9E178F144FAEF2BF4CE739C66801B7645D@exmail1.se.axis.com>
References: <BFECAF9E178F144FAEF2BF4CE739C66801B7645D@exmail1.se.axis.com>
Content-Type: text/plain
Date: Thu, 02 Jun 2005 13:15:44 +0200
Message-Id: <1117710944.6458.38.camel@laptopd505.fenrus.org>
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

On Thu, 2005-06-02 at 12:57 +0200, Mikael Starvik wrote:
> >how about making this a _GPL export?
> 
> Yes
> 
> >also... when are you going to get this module merged?
> 
> Do we really want modules for all kind of exotic hardware only used by one
> company in the kernel tree? In this case we are the only user of this module
> since we make the HW ourself and doesn't resell it. So it's my headache if
> any API or similar is changed.

in which case.... why bloat all linux' users kernel binary with it
(exports cost about 100 bytes each or so) while you're the only user?
For your own kernel it'd be trivial to add that simple export patch
local...


