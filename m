Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261998AbVDGHtD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261998AbVDGHtD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 03:49:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262168AbVDGHtC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 03:49:02 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:14500 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261998AbVDGHst (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 03:48:49 -0400
Subject: Re: Kernel SCM saga..
From: Arjan van de Ven <arjan@infradead.org>
To: Paul Mackerras <paulus@samba.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <16980.55403.190197.751840@cargo.ozlabs.ibm.com>
References: <Pine.LNX.4.58.0504060800280.2215@ppc970.osdl.org>
	 <16980.55403.190197.751840@cargo.ozlabs.ibm.com>
Content-Type: text/plain
Date: Thu, 07 Apr 2005 09:48:44 +0200
Message-Id: <1112860124.6290.24.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
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

On Thu, 2005-04-07 at 16:51 +1000, Paul Mackerras wrote:
> Linus,
> 
> > That "individual patches" is one of the keywords, btw. One thing that BK 
> > has been extremely good at, and that a lot of people have come to like 
> > even when they didn't use BK, is how we've been maintaining a much finer- 
> > granularity view of changes. That isn't going to go away. 
> 
> Are you happy with processing patches + descriptions, one per mail?
> Do you have it automated to the point where processing emailed patches
> involves little more overhead than doing a bk pull?  If so, then your
> mailbox (or patch queue) becomes a natural serialization point for the
> changes, and the need for a tool that can handle a complex graph of
> changes is much reduced.

alternatively you could send an mbox with your series in... that has a
natural sequence in it ;)

