Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261558AbVHBPD0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261558AbVHBPD0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Aug 2005 11:03:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261568AbVHBPD0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Aug 2005 11:03:26 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:50353 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261558AbVHBPDY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Aug 2005 11:03:24 -0400
Subject: Re: [PATCH 00/14] GFS
From: Arjan van de Ven <arjan@infradead.org>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: David Teigland <teigland@redhat.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, linux-cluster@redhat.com
In-Reply-To: <Pine.LNX.4.61.0508021655580.4138@yvahk01.tjqt.qr>
References: <20050802071828.GA11217@redhat.com>
	 <1122968724.3247.22.camel@laptopd505.fenrus.org>
	 <Pine.LNX.4.61.0508021655580.4138@yvahk01.tjqt.qr>
Content-Type: text/plain
Date: Tue, 02 Aug 2005 17:02:52 +0200
Message-Id: <1122994972.3247.31.camel@laptopd505.fenrus.org>
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

On Tue, 2005-08-02 at 16:57 +0200, Jan Engelhardt wrote:
> >* Why use your own journalling layer and not say ... jbd ?
> 
> Why does reiser use its own journalling layer and not say ... jbd ?

because reiser got merged before jbd. Next question.

Now the question for GFS is still a valid one; there might be reasons to
not use it (which is fair enough) but if there's no real reason then
using jdb sounds a lot better given it's maturity (and it is used by 2
filesystems in -mm already).



