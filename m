Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965083AbVKGTHe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965083AbVKGTHe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 14:07:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965271AbVKGTHd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 14:07:33 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:63443 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S965267AbVKGTHb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 14:07:31 -0500
Subject: Re: 2.6 series kernels panic on boot at PCI probe with 450nx
From: Arjan van de Ven <arjan@infradead.org>
To: Greg KH <greg@kroah.com>
Cc: Frank Overton <frank@discoverycenters.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20051107182206.GB18861@kroah.com>
References: <436BF7BB.9070900@discoverycenters.org>
	 <20051105043056.GA25501@kroah.com>
	 <1131384430.26641.31.camel@coco.overtonshome.net>
	 <20051107182206.GB18861@kroah.com>
Content-Type: text/plain
Date: Mon, 07 Nov 2005 20:07:20 +0100
Message-Id: <1131390441.2858.26.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
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



> Ugh, I really wish I knew which ddevice acpi was trying to add here.  It
> looks like it is addding 2 pci busses with the same address, which would
> be very odd.

known bios bug in early 450nx bioses...
bios upgrade usually fixes that.

