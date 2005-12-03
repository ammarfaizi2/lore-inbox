Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932078AbVLCViV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932078AbVLCViV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Dec 2005 16:38:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751297AbVLCViV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Dec 2005 16:38:21 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:58510 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751284AbVLCViU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Dec 2005 16:38:20 -0500
Subject: Re: RFC: Starting a stable kernel series off the 2.6 kernel
From: Arjan van de Ven <arjan@infradead.org>
To: "M." <vo.sinh@gmail.com>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
In-Reply-To: <f0cc38560512031331x3f4006e5sc2ff51414f07ada7@mail.gmail.com>
References: <20051203135608.GJ31395@stusta.de>
	 <9a8748490512030629t16d0b9ebv279064245743e001@mail.gmail.com>
	 <20051203201945.GA4182@kroah.com>
	 <f0cc38560512031254j3b28d579s539be721c247c10a@mail.gmail.com>
	 <20051203211209.GA4937@kroah.com>
	 <f0cc38560512031331x3f4006e5sc2ff51414f07ada7@mail.gmail.com>
Content-Type: text/plain
Date: Sat, 03 Dec 2005 22:38:15 +0100
Message-Id: <1133645895.22170.33.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 1.8 (+)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (1.8 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[213.93.14.173 listed in dnsbl.sorbs.net]
	1.7 RCVD_IN_NJABL_DUL      RBL: NJABL: dialup sender did non-local SMTP
	[213.93.14.173 listed in combined.njabl.org]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> <sorry for the direct reply>
> 
> makes sense, but are you sure having distros like Debian, enterprise
> products from redhat etc using the same 6months release for their
> stable versions does not translate in minor fragmentation on kernel
> development 

I'm quite sure that there isn't significant fragmentation; all those
distros in their maintenance generally only take patches that are
already upstream (or they send them upstream during the maintenance)
just to make sure that their long term costs don't go insane
(eg for the $nextversion, the distros can just start clean because they
know all bugfixes from maintenance versions are already in the new
kernel.org kernel they get; not doing that is REALLY expensive so
distros like to avoid that)


> and in benefits for every user?

you can't have it both ways; you can't be "new" and "old stable" at the
same time. 

> . Another
> advantage would be to benefit external projects and hardware producers
> writing open drivers, enlowering the effort in writing and mantaining
> a driver.

there is an even better model for those: Get it merged into kernel.org!


There is an even bigger deal here: even if you're not ready to get
merged yet, staying on the same old version for 6 months is NOT going to
help you. In fact it's worse: it is 10x easier to deal with 6 small
steps of 1 month than to deal with 1 big step of 6 months. 

