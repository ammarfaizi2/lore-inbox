Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261656AbVDEJol@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261656AbVDEJol (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 05:44:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261628AbVDEJmH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 05:42:07 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:55262 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261670AbVDEJhL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 05:37:11 -0400
Subject: Re: non-free firmware in kernel modules, aggregation and unclear
	copyright notice.
From: Arjan van de Ven <arjan@infradead.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Ian Campbell <ijc@hellion.org.uk>, Sven Luther <sven.luther@wanadoo.fr>,
       "Theodore Ts'o" <tytso@mit.edu>, Greg KH <greg@kroah.com>,
       Michael Poole <mdpoole@troilus.org>, debian-legal@lists.debian.org,
       debian-kernel@lists.debian.org, linux-kernel@vger.kernel.org
In-Reply-To: <20050405093258.GA18523@lst.de>
References: <20050404182753.GC31055@pegasos>
	 <20050404191745.GB12141@kroah.com> <20050404192945.GB1829@pegasos>
	 <20050404205527.GB8619@thunk.org> <20050404211931.GB3421@pegasos>
	 <1112689164.3086.100.camel@icampbell-debian>
	 <20050405083217.GA22724@pegasos>
	 <1112690965.3086.107.camel@icampbell-debian>
	 <20050405091144.GA18219@lst.de>
	 <1112693287.6275.30.camel@laptopd505.fenrus.org>
	 <20050405093258.GA18523@lst.de>
Content-Type: text/plain
Date: Tue, 05 Apr 2005 11:36:58 +0200
Message-Id: <1112693819.6275.36.camel@laptopd505.fenrus.org>
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


> > Second step is to make the built-in firmware a
> > config option and then later on when the infrastructure matures for
> > firmware loading/providing firmware it can be removed from the driver
> > entirely.
> 
> I think the infrasturcture is quite mature.  We have a lot of drivers
> that require it to function.

what seems to be currently missing is distro level support for using
firmware for modules needed for booting (and tg3 falls sort of under
that via nfsroot) and widespread easy availability of firmware in
distros and for users.

Both are a bit of a chick-and-egg thing, and this is what a transition
period with a few key drivers in dual-mode would hopefully resolve.

One of the options is to even ship the firmware in the kernel tarbal but
from a separate directory with a clear license clarification text in it.


