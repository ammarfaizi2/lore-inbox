Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261966AbVFGU7T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261966AbVFGU7T (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Jun 2005 16:59:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261972AbVFGU7T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Jun 2005 16:59:19 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:10636 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261966AbVFGU7P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Jun 2005 16:59:15 -0400
Subject: Re: [PATCH] Move some more structures into "mostly_readonly"
From: Arjan van de Ven <arjan@infradead.org>
To: christoph <christoph@scalex86.org>
Cc: Christoph Hellwig <hch@infradead.org>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.62.0506071258450.2850@ScMPusgw>
References: <Pine.LNX.4.62.0506071128220.22950@ScMPusgw>
	 <20050607194123.GA16637@infradead.org>
	 <Pine.LNX.4.62.0506071258450.2850@ScMPusgw>
Content-Type: text/plain
Date: Tue, 07 Jun 2005 22:59:09 +0200
Message-Id: <1118177949.5497.44.camel@laptopd505.fenrus.org>
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

On Tue, 2005-06-07 at 12:59 -0700, christoph wrote:
> On Tue, 7 Jun 2005, Christoph Hellwig wrote:
> 
> > On Tue, Jun 07, 2005 at 11:30:03AM -0700, christoph wrote:
> > > Move syscall table, timer_hpet and the boot_cpu_data into the "mostly_readonly" section.
> > 
> > the syscall table should be completely readonly.
> 
> Why was it in .data in the first place? There must be some reason why it 
> was writable?

probably a historic oversight.


