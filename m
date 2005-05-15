Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261661AbVEOPBE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261661AbVEOPBE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 May 2005 11:01:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261656AbVEOPBE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 May 2005 11:01:04 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:57749 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261661AbVEOPA6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 May 2005 11:00:58 -0400
Subject: Re: Hyper-Threading Vulnerability
From: Arjan van de Ven <arjan@infradead.org>
To: Tomasz Torcz <zdzichu@irc.pl>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050515145241.GA5627@irc.pl>
References: <1115963481.1723.3.camel@alderaan.trey.hu>
	 <m164xnatpt.fsf@muc.de> <20050513211609.75216bf8.diegocg@gmail.com>
	 <20050515095446.GE68736@muc.de>
	 <Pine.LNX.4.58.0505151550160.8633@artax.karlin.mff.cuni.cz>
	 <20050515141207.GB94354@muc.de>  <20050515145241.GA5627@irc.pl>
Content-Type: text/plain
Date: Sun, 15 May 2005 17:00:49 +0200
Message-Id: <1116169249.6270.25.camel@laptopd505.fenrus.org>
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


> > They turned it off by default, which according to disk vendors
> > lowers the MTBF of your disk to a fraction of the original value.
> > 
> > I bet the total amount of valuable data lost for FreeBSD users because
> > of broken disks is much much bigger than what they gained from not losing
> > in the rather hard to hit power off cases.
> 
>  Aren't I/O barriers a way to safely use write cache?

yes they are. However of course they also decrease the mtbf somewhat,
although less so than entirely disabling the cache....


